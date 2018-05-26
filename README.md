# Dotfiles
This is a version of my config files. It contains an install script that will
1. Make a backup of all the fies to be linked against.
2. Link all the coniguration files and directories into the appropriate place.

### How to Install
Please run the following commands. The script will backup all files that it replaces to a folder in ~/dotfiles/backup. Please note that I'm not responsable for any loss of data or whatever. 
```
cd ~
git clone git@gitlab.sd.apple.com:russell_bentley/dotfiles.git
cd dotfiles
sh installer.sh
```
