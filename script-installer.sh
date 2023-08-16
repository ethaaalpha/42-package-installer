#!/bin/bash
VSCODE_DOWN="vscode-tar"
VSCODE_FINAL="VSCode-linux-x64"

rm -rf $VSCODE_DOWN
rm -rf $VSCODE_FINAL

echo "Installing zsh"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

echo "Fixing 42 school VSCode too"
echo "{
  \"terminal.integrated.defaultProfile.linux\": \"bash\",
  \"terminal.integrated.profiles.linux\": {
    \"bash\": {
      \"path\": \"/usr/bin/flatpak-spawn\",
      \"args\": [\"--host\", \"--env=TERM=xterm-256color\", \"zsh\"]
    }
  }
}" > ~/.var/app/com.visualstudio.code/config/Code/User/settings.json

echo "Downloading vscode"
cp -r "/nfs/sgoinfre/goinfre/Perso/ebillon/$VSCODE_DOWN" .
echo "Extracting vscode"
sleep 1
tar -xf $VSCODE_DOWN
echo "Cleaning .."
rm -rf $VSCODE_DOWN
sed -i "s|Exec=1|Exec=$PWD/$VSCODE_FINAL/code --unity-launch %F|" code.desktop
sed -i "s|Exec=2|Exec=$PWD/$VSCODE_FINAL/code --new-window %F|" code.desktop
sed -i "s|Icon=.*|Icon=$PWD/logo.png|" code.desktop
chmod +x ./code.desktop
cp code.desktop ~/Desktop/

PATHTOADD="$PWD/$VSCODE_FINAL"
echo "export PATH=$PATH:$PATHTOADD" >> ~/.zshrc
echo 'alias code="nohup code . > /dev/null & disown"' >> ~/.zshrc
