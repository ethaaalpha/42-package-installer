#!/bin/bash
VSCODE_DOWN="vscode-tar"
VSCODE_FINAL="VSCode-linux-x64"

rm -rf $VSCODE_DOWN
rm -rf $VSCODE_FINAL

echo "Installing zsh"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo "Downloading vscode"
wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-x64' -O $VSCODE_DOWN
echo "Extracting vscode"
sleep 1
tar -xf $VSCODE_DOWN
echo "Cleaning .."
rm -rf $VSCODE_DOWN

PATHTOADD="$PWD/$VSCODE_FINAL"
echo "export PATH=$PATH:$PATHTOADD" >> ~/.zshrc
echo 'alias code="nohup code . > /dev/null & disown"' >> ~/.zshrc
