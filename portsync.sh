#!/bin/bash

# Script designed to copy changes to a folder and the upload the folder to Github when there are changes
# This script uses User Tokens instead of SSH keys and can be combined with Cron Jobs to schedule automatic backups.

# edit these paths to your desired folders
SOURCE="/home/kumane/Downloads/Portfolio"
DEST="/home/kumane/sambashare/Portfolio"

echo "$(date): Starting sync from $SOURCE to $DEST"

# Check if source folder exists
if [ ! -d "$SOURCE" ]; then
    echo "$(date): ERROR - Source folder does not exist: $SOURCE"
    exit 1
fi

# Create destination folder if it doesn't exist
mkdir -p "$DEST"

# Sync all files from source to destination (protects .git folder)
echo "$(date): Syncing files..."
if rsync -a --delete --exclude='.git' "$SOURCE/" "$DEST/" 2>/dev/null; then
    echo "$(date): File sync completed successfully"
else
    echo "$(date): rsync failed, trying with cp..."
    if cp -ru "$SOURCE"/* "$DEST/" 2>/dev/null; then
        echo "$(date): File copy completed with cp"
    else
        echo "$(date): ERROR - Both rsync and cp failed"
        exit 1
    fi
fi

###COMMENT OUT BELOW SECTION IF GITHUB INTEGRATION IS NOT DESIRED
# Change to destination directory for git operations
cd "$DEST"

# Check if this is a git repository
if [ ! -d ".git" ]; then
    echo "$(date): This folder is not a git repository yet"
    echo "$(date): To set up git, run these commands:"
    echo "  cd $DEST"
    echo "  git init"
    echo "  git remote add origin https://YOUR_TOKEN@github.com/username/repo.git"
    echo "  git add -A"
    echo "  git commit -m 'Initial commit'"
    echo "  git push -u origin main"
    exit 0
fi

# Check if there are changes to commit
if [ -n "$(git status --porcelain)" ]; then
    echo "$(date): Git changes detected, committing and pushing..."
    
    git add -A
    git commit -m "Backup sync: $(date '+%Y-%m-%d %H:%M:%S')"
    
    if git push; then
        echo "$(date): Successfully pushed to GitHub"
    else
        echo "$(date): ERROR - Failed to push to GitHub"
        exit 1
    fi
else
    echo "$(date): No git changes detected"
fi
###COMMENT OUT ABOVE IF GITHUB INTEGRATION IS NOT DESIRED
echo "$(date): Script completed successfully"
