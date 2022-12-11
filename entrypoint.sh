#!/usr/bin/env sh

# Generate the requirements.txt file for the project using the pipreqs command with the --force and --savepath options,
# and using the INPUT_REQUIREMENT_PATH and INPUT_PROJECT_PATH input parameters to specify the path to the requirements.txt
# file and the path to the project directory, respectively.
pipreqs --force --savepath $INPUT_REQUIREMENT_PATH $INPUT_PROJECT_PATH

# Enable the "errexit" option for the shell, which causes the script to exit if any commands return a non-zero exit code.
# This is used to prevent the script from continuing if any errors occur during execution.
set -e

# Add an exception for this directory to the list of "safe" directories, which allows the Git commands in this script
# to be run in this directory without generating a warning message.
git config --global --add safe.directory /github/workspace

# Set the Git user name and email address to the GITHUB_ACTOR environment variable, which specifies the user or organization
# that triggered the workflow. This is used to configure the Git credentials for the user who is running the workflow.
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# Unset the "errexit" option for the shell, which allows the script to continue even if any of the commands return a
# non-zero exit code. This is used to prevent the script from exiting if the git diff-index command returns a non-zero
# exit code, which is expected if there are changes to the requirements.txt file.
set +e

# Check if there are any changes to the requirements.txt file
if git diff-index --quiet HEAD --; then
  # If there are no changes, print a message and exit the script
  echo "No changes to requirements.txt"
  exit 0
else
  # If there are changes, enable the "errexit" option for the shell again, which causes the script to exit if any
  # commands return a non-zero exit code. This is used to prevent the script from continuing if any errors occur
  # during the commit and push operations.
  set -e
  # Stage, commit, and push the changes to the requirements.txt file to the remote Git repository. The INPUT_COMMIT_MESSAGE
  # input parameter is used to specify the commit message for the changes.
  # Stage the changes to the requirements.txt file
  git add -A

  # Create a new commit with the changes to the requirements.txt file, using the INPUT_COMMIT_MESSAGE input parameter
  # to specify the commit message.
  git commit -m "$INPUT_COMMIT_MESSAGE"

  # Push the new commit to the remote Git repository, using the origin remote and the HEAD reference.
  git push -u origin HEAD
fi