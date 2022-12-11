# Automatic requirement.txt for Python Projects on Github

### **FORKED FROM [ryan-rozario/pipreqs-action](https://github.com/ryan-rozario/pipreqs-action) TO USE PYTHON 3.10**

[pipreqs](https://github.com/bndr/pipreqs) - Generates pip requirements.txt file based on imports of any project.

This action will automatically create the requirements.txt file for a python project using the pipreqs tool.

You can specify the location of your project folder that contains all the python files within your repository.
You can specify the path to which your requirement.txt has to be saved.

## Usage

### Example workflow

```yaml
name: Check requirements.txt
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Check requirements.txt
        uses: ekvanox/pipreqs-action@master

        with:
          PROJECT_PATH: {{project_folder}}
          REQUIREMENT_PATH: {{project_folder}}/requirements.txt
          COMMIT_MESSAGE: "My custom commit message"
```

### Inputs

| Input                                             | Description                                        |Default                                        |
|------------------------------------------------------|-----------------------------------------------|-----------------------------------------------|
| `PROJECT_PATH`  | Gives the path to the project folder that contains the python files    |  .
| `REQUIREMENT_PATH`  | Gives the path to the location where requirements.txt has to be saved, including the requirements.txt file name    | requirements.txt|
| `COMMIT_MESSAGE`  | The commit message to use when pushing the updated requirements.txt file | Updated requirements file |
