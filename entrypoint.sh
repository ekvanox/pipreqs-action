#!/usr/bin/env sh

# Run the pipreqs command with the --force and --savepath options, using the INPUT_REQUIREMENT_PATH and INPUT_PROJECT_PATH
# input parameters to specify the path to the requirements.txt file and the path to the project directory, respectively.
# This generates the requirements.txt file for the project.
pipreqs --force --savepath $INPUT_REQUIREMENT_PATH $INPUT_PROJECT_PATH

# Set the -e option for the shell, which causes the script to exit if any commands return a non-zero exit code.
# This is used to prevent the script from continuing if any errors occur during execution.
set -e

# Add an exception for this directory
git config --global --add safe.directory /github/workspace

# Set the Git user name and email address to the GITHUB_ACTOR environment variable, which specifies the user or organization
# that triggered the workflow. This is used to configure the Git credentials for the user who is running the workflow.
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# Stage, commit, and push the changes to the requirements.txt file to the remote Git repository. The INPUT_COMMIT_MESSAGE
# input parameter is used to specify the commit message for the changes.
git add -A && git commit -m "$INPUT_COMMIT_MESSAGE" && git push -u origin HEAD
