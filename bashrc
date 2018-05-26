######################
# Intro
######################

# If this is not an interactive session then we don't need to run all this
# In fact, running this could be a problem.
# For scp and the like
if [[ ! $- =~ "i" ]]
then
    return
fi

function col_echo {
    tput setaf $2
	echo $1
    tput sgr0
}

col_echo "Running ~/.bashrc ..." 3

# The BNI bashrc will setup XBS, and do some other misc things like check ssh keys
. ~bni/rc/bashrc

######################
# Personal Settings
######################
col_echo "Setting up personal stuff ..." 3

# Update prompt
On_h='\[$(tput setaf 13; tput bold)\]'
Off_h='\[$(tput sgr0)\]'
export PS1="${On_h}\W:\u\$ ${Off_h}"
export Ps2="${On_h}> ${Off_h}"

# edit function makes it easier to change settings
function edit {
    case $1 in
    vim)
        vim ~/.vimrc
        ;;
    bash)
        vim ~/.bashrc
        . ~/.bashrc
        ;;
    git)
        vim ~/.gitconfig
        ;;
    esac
}

# escalate priviledges
alias e='sudo bash'

# tmux aliases
alias tmat='tmux attach-session -t'

######################
# Done
######################
col_echo "Done ..." 3
