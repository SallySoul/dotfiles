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
col_echo "Running ~/.zshrc ..." 3

# Update prompt
PROMPT="%{$(tput setaf 16; tput setab 2)%}%1~:%n%{$(tput sgr0; tput setaf 2)%} %{$(tput sgr0)%}"

######################
# Shell  Settings
######################

# Update env variables
export PATH=$PATH:~/dotfiles/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/scripts
export PATH=$PATH:~/.cargo/bin

export EMAIL_ADDRESS='russell.w.bentley@icloud.com'
export NOTES_DIRECTORY=~/projects/notes

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#######################
# Aliases / One Liners
#######################

# escalate priviledges
alias e='sudo zsh'

# tmux aliases
alias tmls='tmux ls'
alias tmks='tmux kill-server'

# git aliases
alias gid='git diff | tee /dev/tty | pbcopy'
alias gist='git status && git diff | tee /dev/tty | pbcopy'
alias gim='git commit -a -m'
alias gip='git pull'
alias gitlog='git log --graph'
alias removeUntrackedFiles='sudo git ls-files --others --exclude-standard | xargs rm -rf'

# less always needs color~
alias less='less -R'

# Info / Inspect aliases
alias i="echo \"host: $(hostname)\"; echo \"CPU Cores: `/usr/sbin/sysctl -n hw.ncpu`\""

# exa aliases
alias ls='exa --all'
alias ll='exa --all --long --header'
alias lll='exa --long --header --color=always | less -R'
alias tree='exa --long --tree -I .git'
alias mtreel='exa --tree -I .git --color=always | less -R'
alias treel='exa --long --tree -I .git --color=always | less -R'

# NeoVim aliases
alias view='nvim -R'
alias vim='nvim'
alias tvim='nvim term://zsh'
alias openProject="find . -regex '\./src/.*\.rs' -or -name Cargo.toml | xargs nvim term://zsh"

# misc aliases
alias fd='fd --hidden'
alias alert='echo "\a"'
alias vzsh='view ~/.zshrc'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# this one gets passed a list of filenames, will return <linecount>\t<filename>
alias len="xargs -n 1 perl -lne 'END { print \"\$.\t\$ARGV\"; }'"

# Work
alias drun='docker run -it -v ${PWD}:/app'
alias drunmklvtk='docker run -it -v ${PWD}:/app ataber/mkl_vtk:master'
alias dcrw='docker-compose run web'
alias dcrwbe='docker-compose run web bundle exec'
alias drails='dcrwbe bin/rails'

######################
# Functions
######################

function colors {
    for i in $(seq 0 16)
    do
        tput setaf $i
        echo "Color: $i"
        tput sgr0
    done
}

# edit function makes it easier to change settings
function edit {
    case $1 in
    vim)
        vim ~/.vimrc
        ;;
    bash)
        vim ~/.bashrc
        ;;
    zsh)
        vim ~/.zshrc
        source ~/.zshrc
        ;;
    git)
        vim ~/.gitconfig
        ;;
    tmux)
        vim ~/.tmux.conf
        tmux source-file ~/.tmux.conf
        ;;
    SpaceVim)
        nvim ~/.SpaceVim.d/init.toml
        ;;
    *)
        echo "$1 is not in edit ..."
        ;;
    esac
}

# Use to attach to tmux sessions, so that ssh forwarding is enabled
# Note that we only want this behaivor when on an ssh connection
function tmat {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
    then
        tmux attach-session -t $1 \; new-window 'source ~/.ssh/latestagent'
    else
        tmux attach-session -t $1
    fi
}

# Run a background job and place it in the temp directory
# Example: bt ls -la
# Example: bt xbs cortex ...
function bt {
    if [ -z ${BT_TEMP_NUM+x} ]
    then
        echo "Initializing BT_TEMP_NUM"
        BT_TEMP_NUM=0
    fi

    echo "Running \"$1\" and placing into t$BT_TEMP_NUM.txt"
    eval "$@ > ~/temp/t$BT_TEMP_NUM.txt &"
    BT_TEMP_NUM=$(($BT_TEMP_NUM+1))
}

# View the result of the last background job from bt
function btv {
    if [ -z ${BT_TEMP_NUM+x} ]
    then
        echo "BT_TEMP_NUM not initialized, try looking in ~/temp manually"
        echo "ls ~/temp"
    else
        view ~/temp/t$(($BT_TEMP_NUM-1)).txt
    fi
}

# cat the result of the last background job from bt
function btc {
    if [ -z ${BT_TEMP_NUM+x} ]
    then
        echo "BT_TEMP_NUM not initialized, try looking in ~/temp manually"
        echo "ls ~/temp"
    else
        cat ~/temp/t$(($BT_TEMP_NUM-1)).txt
    fi
}

######################
# Done
######################
col_echo "Done ..." 3
