#!/bin/bash

# Exit on any error
set -e

echo "📚 Syncing assets to widgetbook..."

# Define files to sync (add more files here as needed)
FILES_TO_SYNC=(
  "README.md"
  # Add more files here in the future, e.g.:
  # "CHANGELOG.md"
  # "docs/API.md"
)

# Create assets directory if it doesn't exist
mkdir -p widgetbook/assets

# Copy each file
for file in "${FILES_TO_SYNC[@]}"; do
  if [ -f "$file" ]; then
    # Extract filename from path for destination
    filename=$(basename "$file")
    # Copy with _COPIED suffix to avoid conflicts
    destination="widgetbook/assets/${filename%.*}_COPIED.${filename##*.}"
    
    cp "$file" "$destination"
    echo "✅ Copied $file to $destination"
  else
    echo "⚠️  Warning: $file not found, skipping..."
  fi
done

# Extract version from pubspec.yaml and create version file
echo "📋 Extracting version from pubspec.yaml..."
if [ -f "pubspec.yaml" ]; then
  # Extract version using grep and sed
  VERSION=$(grep "^version:" pubspec.yaml | sed 's/version: *//g' | sed 's/ *#.*//g')
  
  if [ -n "$VERSION" ]; then
    echo "$VERSION" > "widgetbook/assets/UNPING_UI_VERSION.md"
    echo "✅ Version $VERSION written to widgetbook/assets/UNPING_UI_VERSION.md"
  else
    echo "⚠️  Warning: Could not extract version from pubspec.yaml"
    echo "unknown" > "widgetbook/assets/UNPING_UI_VERSION.md"
  fi
else
  echo "⚠️  Warning: pubspec.yaml not found"
  echo "unknown" > "widgetbook/assets/UNPING_UI_VERSION.md"
fi

echo "🎉 All assets synced successfully!"

# Only show run instructions in local development (not CI)
if [ -z "$CI" ]; then
  echo "You can now run: cd widgetbook && flutter run"
fi
