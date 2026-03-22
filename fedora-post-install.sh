# install rpm fusion
echo
echo "install rpm fusion"
echo
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

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
gtk-murrine-engine \
sassc \
flatpak \
brave-browser \
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

# final upgrade
echo
echo "final upgrade"
echo
sudo dnf upgrade -y

# reboot
echo
echo "reboot"
echo
shutdown -r
