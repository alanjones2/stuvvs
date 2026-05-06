#!/bin/bash

# Default values
DEFAULT_PROJECT_NAME="myproject"
DEFAULT_PYTHON_VERSION="3.13"

# 1. Ask the user for the name of the project
read -p "Enter project name [$DEFAULT_PROJECT_NAME]: " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-$DEFAULT_PROJECT_NAME}

# 2. Ask for the version of Python
read -p "Enter Python version [$DEFAULT_PYTHON_VERSION]: " PYTHON_VERSION
PYTHON_VERSION=${PYTHON_VERSION:-$DEFAULT_PYTHON_VERSION}

# 3. Ask for a list of libraries to be installed
echo
echo "Streamlit will be installed by default."
read -p "Enter additional libraries to install (space-separated) [none]: " LIBRARIES

# 4. Prompt the user with the data entered
echo -e "\nProject Summary:"
echo "----------------"
echo "Project Name:   $PROJECT_NAME"
echo "Python Version: $PYTHON_VERSION"
echo "Libraries:      streamlit $LIBRARIES"
echo "----------------"
read -p "Proceed with these settings? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
    echo "Setup cancelled."
    exit 0
fi

# 5. Use UV to initialise a new folder
echo "Initializing project $PROJECT_NAME..."
uv init "$PROJECT_NAME" --python "$PYTHON_VERSION"

cd "$PROJECT_NAME" || exit

# 6. uv add the libraries
echo "Adding libraries: streamlit $LIBRARIES..."
uv add streamlit $LIBRARIES

# 7. Create .vscode folder and tasks.json
echo "Configuring VSCode tasks..."
mkdir -p .vscode
cat <<EOF > .vscode/tasks.json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Streamlit: Run Current File",
            "type": "shell",
            "command": "uv run streamlit run \${file}",
            "group": {
                "kind": "test",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "dedicated",
                "clear": true
            },
            "problemMatcher": []
        }
    ]
}
EOF

# 8. Replace main.py with the provided text
echo "Setting up main.py..."
cat <<EOF > main.py
import streamlit as st

st.title("Welcome to $PROJECT_NAME")
EOF

# 9. Run vscode from the project directory
echo "Opening project in VSCode..."
code .
