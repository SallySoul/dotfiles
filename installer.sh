function col_echo {
    tput setaf $2
	echo "$1"
    tput sgr0
}

# These files exists, <file> exist in dotfiles, and need to be linked to .<file> in ~
baseFiles="spacemacs tmux.conf bashrc bash_profile gitconfig zshrc"
# These are like the above, except that they are directories. 
baseDirs="SpaceVim.d"

############################
# Backup
############################

col_echo "Performing backup ..." 3

# Create directory to put them in
backupdir=~/dotfiles/backup/$(date "+%Y-%d-%h-%m-%s")
mkdir -p $backupdir

# Backup all relavent files
for f in $baseFiles $baseDirs
do
    col_echo "\tBacking up ~/.$f ..." 5
    if [ -e ~/.$f ]
    then
        mv ~/.$f $backupdir/$f
        col_echo "\t\tDone ..." 6
    else
        col_echo "\t\tNot found..." 6
    fi
done

col_echo "Done with backup ..." 3

############################
# Installation
############################

col_echo "Creating links ..." 3
# create hard links for files
for l in $baseFiles
do
    col_echo "\tlinking $l to ~/.$l ..." 5
    ln -s -f ~/dotfiles/$l ~/.$l
done
# create symbollic links for directories
for l in $baseDirs
do
    col_echo "\tlinking $l to ~/.$l ..." 5
    ln -s -f ~/dotfiles/$l ~/.$l
done

col_echo "Adding LaunchAgents ..." 3
ditto LaunchAgents ~/Library/LaunchAgents

col_echo "Done ..." 3
