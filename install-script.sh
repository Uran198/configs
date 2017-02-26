#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install \
  vim-gtk3\
  git\
  python-pip\
  python3-pip\
  zsh\
  python-gpgme\
  keepassx\
  unrar\
  libxft2\    # Freetype (needed for matplotlib to work correctly)
  libxft2-dev

pip install -U pip
pip3 install -U pip
pip install virtualenv
pip3 install virtualenv virtualenvwrapper
mkdir ~/.virtualenv

cd ~
git clone --recursive https://github.com/Uran198/.vim
vim +PluginInstall +qall

git config --global user.name "Attila"
git config --global user.email "uran198@gmail.com"

ln $HOME/configs/zshrc $HOME/.zshrc
chsh -s /bin/zsh

sudo tee -a /etc/fstab <<EOF
# /dev/sda11
UUID=bb349b71-64d9-42cd-96bd-abc2ccb5a8bb /media/data ext4              rw,relatime,data=ordered           0 2
EOF

# Create links to default directories
sudo mount /dev/sda11 /media/data
ln -s /media/data/data/read_this $HOME/read_this
ln -s /media/data/data/notex $HOME/notex
ln -s /media/data/data $HOME/data

files=( "Documents" "Downloads" "Music" "Pictures" "Projects" )
for fname in "${files[@]}"
do
    rmdir $HOME/$fname
    ln -s /media/data/data/$fname $HOME/$fname
done

