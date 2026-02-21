---
description: Add a new dependency and sync the project documentation
---

# Add New Dependency Workflow

Use this workflow when adding a new package to the project to ensure the code generation and documentation are properly synced.

## Steps

### 1. Add the Package

Use the command line to add the package to `pubspec.yaml`.

// turbo

```powershell
flutter pub add <package_name>
```

### 2. Fetch Dependencies

Ensure all packages are downloaded and the lockfile is updated.

// turbo

```powershell
flutter pub get
```

### 3. Run Code Generation

If the new package uses `injectable`, `freezed`, `json_serializable`, or `flutter_gen`, run the build runner.

// turbo

```powershell
dart run build_runner build
```

### 4. Sync README.md

Update the "Dependencies Used" section in `README.md`:

1. Identify the package and its version in `pubspec.yaml`.
2. Add it to the correct category in its respective section of `README.md`.
3. Provide a short description and emoji.

### 5. Verify Setup

Run a quick build or test to ensure the new dependency doesn't conflict with existing ones.