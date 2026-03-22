# install rpm fusion
echo
echo "install rpm fusion"
echo
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# copy dotfiles
echo
echo "copy dotfiles"
echo
# tmux
mkdir ~/.config/tmux
cp ../tmux/tmux.conf ~/.config/tmux

# install development tools
echo
echo "install development tools"
echo
sudo dnf group install c-development development-tools -y

# install apps and multimidea
echo
echo "install apps and multimidea"
echo
sudo dnf install gnome-tweaks \
gnome-extensions-app \
gnome-shell-extension-user-theme \
gnome-themes-extra \
tmux \
gtk-murrine-engine \
sassc \
flatpak \
discord \
transmission \
vlc \
ffmpeg --allowerasing -y

sudo flatpak install -y flathub com.mattjakeman.ExtensionManager

# download papirus icons
echo
echo "download papirus icons"
echo
wget -qO- https://git.io/papirus-icon-theme-install | env EXTRA_THEMES="Papirus-Dark" DESTDIR="$HOME/.icons" sh
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C deeporange --theme Papirus-Dark

# install orchis-theme
echo
echo "install orchis-theme"
echo
git clone https://github.com/vinceliuice/Orchis-theme.git ./orchis-theme
cd orchis-theme
./install.sh -t orange -c dark --tweaks macos --tweaks primary --tweaks dock
sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
cd ..
sudo rm -rf orchis-theme

# install tmux tpm
echo
echo "install tmux tpm"
echo
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install nerd font
echo
echo "install nerd font"
echo
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ./nerdfont
sudo mkdir -p /usr/share/fonts/jetbrains-mono-nerd-font
sudo cp -R ./nerdfont/JetBrainsMonoNerdFont-*.ttf /usr/share/fonts/jetbrains-mono-nerd-font
sudo fc-cache -fv
sudo rm -rf nerdfont JetBrainsMono.zip

# final upgrade
echo
echo "final upgrade"
echo
sudo dnf upgrade -y

# set custom prompt
echo
echo "set custom prompt"
echo
if ! grep -q "PS1" ~/.bashrc; then
	cat custom-prompt.txt >> ~/.bashrc
fi
source ~/.bashrc

# reboot
echo
echo "reboot"
echo
shutdown -r
