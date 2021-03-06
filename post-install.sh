#!/bin/sh
# This shell script is meant to automate a post-installation process
# adapted for the following distrubution: Elementary OS Freya 0.3.1 
# auth: mpescimoro

# system upgrade
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes dist-upgrade

# system clean
sudo apt-get -y purge midori-granite geary scratch-text-editor
sudo apt-get -y autoremove
sudo apt-get -y autoclean

# additional repository
sudo add-apt-repository -y ppa:linrunner/tlp
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:atareao/telegram
sudo apt-get -y --force-yes update

# install application
sudo apt-get -y install \
virtualbox virtualbox-guest-additions-iso gparted gimp \
firefox thunderbird gedit gedit-plugins vlc dconf-tools \
transmission icedtea-7-plugin openjdk-7-jre openjdk-7-jdk \
libreoffice numix-icon-theme-circle git tlp tlp-rdw telegram \
nvidia-331


# reducing swappiness
sudo bash -c "echo 'vm.swappiness = 10' >> /etc/sysctl.conf"

# system settings
gsettings set org.pantheon.desktop.slingshot columns 4
gsettings set org.pantheon.desktop.wingpanel auto-adjust-alpha false
gsettings set org.pantheon.desktop.wingpanel background-alpha 0.8
gsettings set org.pantheon.desktop.gala.appearance button-layout close:minimize,maximize
gsettings set org.gnome.desktop.interface icon-theme Numix-Circle

# more system settings
dconf write /com/canonical/indicator/keyboard/visible false
dconf write /org/gnome/settings-daemon/peripherals/touchpad/scroll-method "'two-finger-scrolling'"
dconf write /org/gnome/settings-daemon/peripherals/touchpad/natural-scroll false
dconf write /org/gnome/settings-daemon/peripherals/touchpad/tap-to-click true


# required interaction
# ubuntu-restricted-extras
sudo apt-get -y install ubuntu-restricted-extras

# dropbox
git clone https://github.com/zant95/elementary-dropbox /tmp/elementary-dropbox
bash /tmp/elementary-dropbox/install.sh -y


# required reboot
clear
echo "post-install process is completed, you may need to reboot your system"
