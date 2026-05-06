# stuvvs: Streamlit + UV + VSCode

`stuvvs` is a simple automation tool designed to bootstrap Streamlit application development. It streamlines the process of setting up a modern Python environment using `uv` and configures VSCode for an optimal development experience.

## Features

- **Interactive Setup**: Customize your project name, Python version, and additional dependencies.
- **`uv` Integration**: Fast and reliable environment management with `uv init` and `uv add`.
- **VSCode Optimized**: Automatically creates a `.vscode/tasks.json` to run your Streamlit app directly from the editor.
- **Boilerplate Included**: Generates a basic `main.py` to get you started immediately.

## Prerequisites

Ensure you have the following installed:

- [uv](https://github.com/astral-sh/uv)
- [Visual Studio Code](https://code.visualstudio.com/)
- A Bash-compatible shell (Linux, macOS, or WSL)

## Usage

1. Clone or download this repository, or just download the script file `setup-streamlit.sh`/`setup-streamlit.bat`
2. Run the setup script:

   ```bash
   bash setup-streamlit.sh
   ```

3. Follow the interactive prompts:
   - **Project Name**: Choose a name for your project directory (default: `myproject`).
   - **Python Version**: Specify the Python version (default: `3.13`).
   - **Additional Libraries**: List any extra packages you need (Streamlit is included by default).

4. Once confirmed, the script will:
   - Create the project directory.
   - Initialize the `uv` environment.
   - Install dependencies.
   - Configure VSCode tasks.
   - Open the new project in VSCode.

## VSCode Task

The project comes pre-configured with a VSCode task: **"Streamlit: Run Current File"**. 
You can trigger it via the Command Palette (`Ctrl+Shift+P`) by selecting **Tasks: Run Test Task** (as it is set to the `test` group) or by binding it to a shortcut. It executes:

```bash
uv run streamlit run ${file}
```

## Project Structure

After running the script, your project will look like this:

```text
<project-name>/
├── .vscode/
│   └── tasks.json
├── main.py
├── pyproject.toml
└── uv.lock
```
