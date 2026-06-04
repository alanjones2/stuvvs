@echo off
setlocal enabledelayedexpansion

:: Default values
set DEFAULT_PROJECT_NAME=myproject
set DEFAULT_PYTHON_VERSION=3.13

:: 1. Ask the user for the name of the project
set /p "PROJECT_NAME=Enter project name [%DEFAULT_PROJECT_NAME%]: "
if "%PROJECT_NAME%"=="" set PROJECT_NAME=%DEFAULT_PROJECT_NAME%

:: 2. Ask for the version of Python
set /p "PYTHON_VERSION=Enter Python version [%DEFAULT_PYTHON_VERSION%]: "
if "%PYTHON_VERSION%"=="" set PYTHON_VERSION=%DEFAULT_PYTHON_VERSION%

:: 3. Ask for a list of libraries to be installed
echo.
echo Streamlit will be installed by default.
set /p "LIBRARIES=Enter additional libraries to install (space-separated) [none]: "

:: 4. Prompt the user with the data entered
echo.
echo Project Summary:
echo ----------------
echo Project Name:   %PROJECT_NAME%
echo Python Version: %PYTHON_VERSION%
echo Libraries:      streamlit %LIBRARIES%
echo ----------------
set /p "CONFIRM=Proceed with these settings? (y/n): "

if /i not "%CONFIRM%"=="y" (
    echo Setup cancelled.
    exit /b 0
)

:: 5. Use UV to initialise a new folder
echo Initializing project %PROJECT_NAME%...
uv init "%PROJECT_NAME%" --python "%PYTHON_VERSION%"

cd "%PROJECT_NAME%" || exit /b 1

:: 6. uv add the libraries
echo Adding libraries: streamlit %LIBRARIES%...
uv add streamlit %LIBRARIES%

:: 7. Create .vscode folder and tasks.json
echo Configuring VSCode tasks...
if not exist .vscode mkdir .vscode

(
    echo {
    echo     "version": "2.0.0",
    echo     "tasks": [
    echo         {
    echo             "label": "Streamlit: Run Current File",
    echo             "type": "shell",
    echo             "command": "uv run streamlit run ${file}",
    echo             "group": {
    echo                 "kind": "test",
    echo                 "isDefault": true
    echo             },
    echo             "presentation": {
    echo                 "reveal": "always",
    echo                 "panel": "dedicated",
    echo                 "clear": true
    echo             },
    echo             "problemMatcher": []
    echo         }
    echo     ]
    echo }
) > .vscode\tasks.json

:: 8. Replace main.py with the provided text
echo Setting up main.py...
(
    echo import streamlit as st
    echo.
    echo st.title("Welcome to %PROJECT_NAME%"^)
) > main.py

:: 9. Open VSCode from the project directory
echo Opening project in VSCode...
code .
uv run streamlit run main.py
endlocal