#!/bin/zsh

# Script to copy .devcontainer to user's home directory and update shell rc file

DEVCONTAINER_SRC="$(pwd)/.devcontainer"
DEVCONTAINER_DEST="$HOME/.devcontainer"

# Copy .devcontainer to home directory
if [ -d "$DEVCONTAINER_SRC" ]; then
	cp -R "$DEVCONTAINER_SRC" "$DEVCONTAINER_DEST"
	echo ".devcontainer copied to $HOME/.devcontainer"
else
	echo ".devcontainer directory not found in current directory."
	exit 1
fi


# Line to add alias to shell rc file
DEVCONTAINER_LINE="# Added by mac-setup-script: alias for devcontainer setup"
DEVCONTAINER_ALIAS_LINE="alias configDevContainer='bash ~/.devcontainer/setup_devcontainer.sh'"

# Detect default shell
DEFAULT_SHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')

if [[ "$DEFAULT_SHELL" == *"zsh" ]]; then
	RC_FILE="$HOME/.zshrc"
elif [[ "$DEFAULT_SHELL" == *"bash" ]]; then
	RC_FILE="$HOME/.bashrc"
else
	echo "Default shell is $DEFAULT_SHELL. Not zsh or bash."
	exit 1
fi

# Add alias to rc file if not already present
if ! grep -q "$DEVCONTAINER_ALIAS_LINE" "$RC_FILE"; then
    echo "\n$DEVCONTAINER_LINE" >> "$RC_FILE"
    echo "$DEVCONTAINER_ALIAS_LINE" >> "$RC_FILE"
    echo "Added devcontainer alias to $RC_FILE"
else
    echo "devcontainer alias already present in $RC_FILE"
fi
