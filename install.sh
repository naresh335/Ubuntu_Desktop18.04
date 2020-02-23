#installing common tools
echo "###################### Installing common tools ############################"
sudo apt update
sudo apt install git curl zsh thunderbird chromium-browser clipit chrome-gnome-shell dconf-editor gnome-tweak-tool fonts-powerline gparted -y

#customizing ubuntu dock
echo "###################### Customizing Ubuntu Dock ############################"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24

#customizing zsh
echo "###################### Customizing zsh Shell ############################"
echo 'alias ll="ls -laht"' >> ~/.zshrc
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME.*/ZSH_THEME="agnoster"/g' ~/.zshrc
if grep -qF "plugins=(git)" ~/.zshrc; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	sed -i 's/plugins=(.*/plugins=(/g' ~/.zshrc
	sed -i '/^plugins=(.*/a git' ~/.zshrc
	sed -i '/^git.*/a zsh-syntax-highlighting' ~/.zshrc
	sed -i '/^zsh-syntax-highlighting.*/a zsh-autosuggestions'
	sed -i '/^zsh-autosuggestions.*/a )' ~/.zshrc
fi
source ~/.zshrc
#isntalling copyq advanced clipper
echo "###################### Installing CopyQ ############################"
sudo add-apt-repository ppa:hluk/copyq -y
sudo apt update
sudo apt install copyq
sudo add-apt-repository --remove ppa:hluk/copyq -y

#installing sublime-text
echo "###################### Installing Sublime-Text ############################"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
sudo rm /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update

#installing remmina
echo "###################### Installing Remmina #############################"
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next -y
sudo apt-get update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret
sudo apt-get upgrade -y
sudo apt-add-repository --remove ppa:remmina-ppa-team/remmina-next -y

#replacing snaps with original packages
echo "###################### Replacing Snaps #################################"
sudo snap remove gnome-calculator gnome-characters gnome-logs gnome-system-monitor -y
sudo apt install gnome-calculator gnome-characters gnome-logs gnome-system-monitor -y

echo "##################### Installing Font Fira Code #########################"
wget https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip
unzip FiraCode_2.zip -d FiraCode
mkdir ~/.fonts
cp FiraCode/ttf/* ~/.fonts/FiraCode/
fc-cache -f -v
rm -r FiraCode
rm FiraCode_2.zip

echo "##################### Installing Terminator #########################"
sudo apt-get install terminator
echo "[global_config]
  enabled_plugins = LaunchpadCodeURLHandler, APTURLHandler, LaunchpadBugURLHandler
  suppress_multiple_term_dialog = True
  title_transmit_bg_color = "#000000"
[keybindings]
  next_profile = <Primary>Right
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      profile = default
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    background_darkness = 0.8
    background_type = transparent
    cursor_color = "#aaaaaa"
    font = Fira Code 11
    foreground_color = "#ffffff"
    palette = "#073642:#dc322f:#73d216:#b58900:#268bd2:#d33682:#2aa198:#eee8d5:#f6f700:#fa4710:#edd400:#657b83:#839496:#6c71c4:#93a1a1:#fdf6e3"
    show_titlebar = False
    use_system_font = False
  [[New Profile]]
    cursor_color = "#aaaaaa"
    font = Fira Code 11
    foreground_color = "#ffffff"
    palette = "#073642:#dc322f:#73d216:#b58900:#268bd2:#d33682:#2aa198:#eee8d5:#f6f700:#fa4710:#edd400:#657b83:#839496:#6c71c4:#93a1a1:#fdf6e3"
    show_titlebar = False
    use_system_font = False
" > ~/.config/terminator/config

echo "####################### Customizing theme #############################"
wget https://gitlab.com/LinxGem33/X-Arc-White/uploads/26bccc81678392584149afa3167f8e78/osx-arc-collection_1.4.7_amd64.deb
sudo apt install ./osx-arc-collection_1.4.7_amd64.deb
rm osx-arc-collection_1.4.7_amd64.deb
wget https://github.com/naresh335/linux-tools/releases/download/v1.0/OSX-ElCap.tar.xz
tar xf OSX-ElCap.tar.xz
cd OSX-ElCap
chmod +x ./install.sh
./install.sh
rm -r OSX-ElCap
rm OSX-ElCap.tar.xz

gsettings set org.gnome.desktop.interface icon-theme "Paper"
gsettings set org.gnome.desktop.interface cursor-theme "OSX-ElCap"
gsettings set org.gnome.desktop.interface gtk-theme "OSX-Arc-Plus"
gsettings set org.gnome.desktop.interface show-battery-percentage "true"
gsettings set org.gnome.desktop.interface clock-show-date "true"
gsettings set org.gnome.desktop.interface enable-animations "false"
gsettings set org.gnome.shell.extensions.dash-to-dock click-action "minimize"
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action "cycle-windows"

echo "###################### Installing Ulauncher ############################"
wget https://github.com/Ulauncher/Ulauncher/releases/download/5.6.1/ulauncher_5.6.1_all.deb
sudo apt install ./ulauncher_5.6.1_all.deb
rm ulauncher_5.6.1_all.deb
ulauncher

#print system info
echo "############################## CPU info #################################"
lscpu | grep CPU
echo "############################## Memory info ##############################"
free -mh
echo "############################## OS Release ###############################"
cat /etc/os-release