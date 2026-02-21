---
description: Sync README.md with newly added packages from pubspec.yaml
---

# Sync README Packages Workflow

This workflow ensures that the project documentation stays up-to-date with the latest dependencies.

## Steps

### 1. Analyze Dependencies

Compare the `dependencies` and `dev_dependencies` sections in `pubspec.yaml` with the "Dependencies Used" section in `README.md`. Identify any packages that have been added but not yet documented.

### 2. Categorize New Packages

Classify the identified packages into the existing categories in `README.md`:

- **Architecture & State Management**
- **Backend & Data**
- **UI & Assets**
- **Utilities & Dev Tools**

### 3. Update README.md

Insert the new packages into their respective categories in `README.md`. Follow the established format:

- `package_name: ^version` - Short description with a relevant emoji.

// turbo

### 4. Verify Project Sync

Run `flutter pub get` to ensure all dependencies are correctly resolved.

```powershell
flutter pub get
```

### 5. Final Review

Check the `README.md` for any broken links or formatting issues after the update.

// turbo

### 6. Push Changes to GitHub

Commit the changes to `README.md` and push them to the current branch.

```powershell
git add README.md
git commit -m "docs: sync readme with latest packages"
git push
```
