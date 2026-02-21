---
description: Initialize or restore the .vscode configuration folder and files
---

# Initialize VS Code Configuration Workflow

Use this workflow to create or restore the `.vscode` folder with standard settings and launch configurations for this Flutter project.

## Steps

### 1. Create .vscode Directory

Ensure the `.vscode` directory exists in the project root.

// turbo

```powershell
if (!(Test-Path .vscode)) { New-Item -ItemType Directory -Path .vscode }
```

### 2. Create settings.json

Create the `settings.json` file with the project-specific settings.

// turbo

```powershell
@"
{
    "cmake.sourceDirectory": "E:/FlutterProjects/evira_e_commerce/linux"
}
"@ | Out-File -FilePath .vscode/settings.json -Encoding utf8
```

_Note: The cmake path currently points to a specific external directory as per existing project configuration._

### 3. Create launch.json

Create the `launch.json` file with the Flutter launch configuration.

// turbo

```powershell
@"
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter Run (No Debug)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "noDebug": true
    }
  ]
}
"@ | Out-File -FilePath .vscode/launch.json -Encoding utf8
```

### 4. Verify Files

Ensure the files are correctly created and contain the expected JSON.

// turbo

```powershell
Get-ChildItem .vscode
```
