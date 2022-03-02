---
sort: 41
---

# VScode setting

[Visual Studio Code](https://code.visualstudio.com/) is free, lightweight and platform independent.
 
![pic](https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Visual_Studio_Code_1.35_icon.svg/113px-Visual_Studio_Code_1.35_icon.svg.png)


## I. [Windows](https://code.visualstudio.com/docs/setup/windows)

Can install the Visual Studio Code installer for Windows, or use Zip archive, extract it and run Code from there. <br>
By default, VS Code is installed under C:\users\{username}\AppData\Local\Programs\Microsoft VS Code.

### Python in Visual Studio Code
* Install the Python extension for VS Code (Microsoft)
* Install a Python interpreter

a. Select and Activate an environment
* Select Interpreter: Command Palette (Ctrl+Shift+P) --> Python:Select Interpreter
with Anaconda distribution, use ('base':conda)
__this sets the python.pythonPathvalue in workspace settings to the path of the interpreter. To see the setting, select File > Preferences > Settings > Workspace Settings tab.

* Set default interpreter: to set up a default interpreter for your applications, you can instead add an entry for python.pythonPath manually inside your User Settings.
Command Palette (Ctrl+Shift+P) > Preferences: Open User Settings > python.pythonPath

* Manually specify an interpreter
If VS Code does not automatically locate an interpreter you want to use, you can set the path to it manually in your Workspace Settings settings.json file
File (Code on macOS) > Preferences > Setting > Workspace
Then do any of the following steps:

Create or modify an entry for python.pythonPath with the full path to the Python executable (if you edit settings.json directly, add the line below as the setting):

        Windows: "python.pythonPath": "c:/python36/python.exe",
        macOS/Linux: "python.pythonPath": "/home/python36/python",



## II. To change the indentation based on programming language:

https://stackoverflow.com/questions/34174207/how-to-change-indentation-in-visual-studio-code

https://code.visualstudio.com/docs/editor/intellisense

Open the Command Palette (CtrlShiftP | macOS: ⇧⌘P)
Preferences: Configure language specific settings... (command id: workbench.action.configureLanguageBasedSettings)
Select programming language (for example: lammps)
Add this code:

```js
"[lammps]": {
    "editor.tabSize": 2
}
```


Setting.json
Open the command palette (either with F1 or Ctrl+Shift+P)
Type "open settings"
```js
{
    "files.autoSave": "afterDelay",
    
    "editor.rulers": [80 ],

    "workbench.colorTheme": "Monokai++",
    "workbench.sideBar.location": "left",
    "workbench.activityBar.visible": true,
    "workbench.editorAssociations": {
        "*.ipynb": "jupyter-notebook"
    },
    "workbench.iconTheme": "vscode-icons",

    "files.associations": {
        "*.lmp": "lmps",
        "*.in": "lmps",
        "*.mod": "lmps",
        "*.lmp*": "lmps",
        "*.log": "log",
        "*.out": "log",
        "*.txt": "txt",
        "*.py": "python",
        "*.md": "markdown"
    },

    "[lmps]": {
        "editor.tabSize": 2,
        "editor.snippetSuggestions": "none",
    },

    "[markdown]": {
        "editor.tabSize": 4,
        "editor.snippetSuggestions": "none",
    },
   

    "window.zoomLevel": 0,

    "python.testing.cwd": "",
    "python.condaPath": "C:\\DevProgram\\miniconda3\\condabin",
    "python.defaultInterpreterPath": "C:\\DevProgram\\miniconda3\\python.exe",

    "C_Cpp.updateChannel": "Insiders",
    "jupyter.sendSelectionToInteractiveWindow": true,

    "security.workspace.trust.enabled": false,
    "notebook.cellToolbarLocation": {
        "default": "right",
        "jupyter-notebook": "left"
    },
    "workbench.colorTheme": "Monokai++",

}
```


## III. Useful extensions
- Lammps Syntax Highlight       (ThFriedrich)
- Monokai++                     (Davide Casella)
- Python                        (Microsoft)