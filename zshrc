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
if [ $INSIDE_EMACS ]
then
    col_echo "Emacs Session" 5
    PROMPT="%{$(tput setaf 2)%}%1~:%n$%{$(tput sgr0)%} "
else
    col_echo "Not in Emacs" 5
    PROMPT="%{$(tput setaf 16; tput setab 2)%}%1~:%n%{$(tput sgr0; tput setaf 2)%} %{$(tput sgr0)%}"
fi

# Optionally source Virtual Env
if [ -d ~/.venv/bin/ ]
then
    col_echo "Setting up python virtual environtment" 3
    export VIRTUAL_ENV_DISABLE_PROMPT=YES
    source ~/.venv/bin/activate
fi

######################
# Shell  Settings
######################

# Update env variables
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/.cargo/bin

# What's this for again?
export EMAIL_ADDRESS='russell.w.bentley@icloud.com'

# Why do we have this again?
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

# git aliases
alias gdi='git diff --no-index'
alias gis='git status'
alias gid='git diff | tee /dev/tty | pbcopy'
alias gist='git status && git diff | tee /dev/tty | pbcopy'
alias gim='git commit -a -m'
alias gip='git pull'
alias gitlog='git log --graph'
alias removeUntrackedFiles='sudo git ls-files --others --exclude-standard | xargs rm -rf'
alias fixSubmodules='git submodule update --init --recursive'
alias git-clang-form="git status | \
rg '\W+(modified|new file):\W+([a-zA-Z./]+)' -r '$2' | \
rg '\.(cpp|h)$' | \
xargs clang-format -i --style=file"

# less always needs color~
alias less='less -R'

# Info / Inspect aliases
alias ip="ifconfig | rg 'inet\s+(\d{3}\.\d{3}\.\d\.\d{3})' -o -r '\$1'"
alias i="echo \"host: $(hostname)\"; echo \"ip: `ip`\"; echo \"CPU Cores: `/usr/sbin/sysctl -n hw.ncpu`\""
alias spacereport="du -h -d 2 . | sort -k 1 -h | less"

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
alias emacs='emacsclient -n'
alias fixSubmodules='git submodule update --init --recursive'
alias runSketch='processing-java --sketch=$(pwd) --output=$(pwd)/output --force --run'
alias spotify='spotify --force-device-scale-factor=1.7'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias fixSound='sudo alsa force-reload'
alias typeracer='npm - -global typeracer-cli'
alias fullpath='echo $(pwd)/$1'

# this one gets passed a list of filenames, will return <linecount>\t<filename>
alias len="xargs -n 1 perl -lne 'END { print \"\$.\t\$ARGV\"; }'"

# Work
alias drun='sudo docker run -it -v ${PWD}:/app'
alias drunmklvtk='sudo docker run --privileged -it -v ${PWD}:/app ataber/mkl_vtk:master'
alias drunmfem='sudo docker run --privileged -it -v ${PWD}:/app ataber/mfem_mkl:master'
alias drunubuntu='sudo docker run --privileged -it -v ${PWD}:/app ubuntu'
alias dcrw='sudo docker-compose run web'
alias dcrwbe='sudo docker-compose run web bundle exec'
alias drails='sudo dcrwbe bin/rails'
alias docker-clean="sudo docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi"

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

# tmux aliases
alias tmls='tmux ls'
alias tmks='tmux kill-server'

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

# Knowledge Poor Man's C++ type finder
# Usage: findType <Type>
function findType {
  rg "(struct|class|trait|enum|using)\W*$1"
}

# Run clang-format-10 on all new or modified .cpp or .h files in dir
function formatChanges {
    git status | \
    rg '\W+(modified|new file):\W+([a-zA-Z./]+)' -r '$2' | \
    rg '\.(cpp|h)$' | \
    xargs clang-format-10 -i --style=file
}

# Kills program matching regex
function killProgram {
    PROGRAM=$1
    ps -aux | rg -i $PROGRAM | head -n -1 | rg '^russell\W*(\d+).*' -r '$1' | xargs kill
}

function killDiscord {
    PROGRAM=discord
    ps -aux | rg -i $PROGRAM | head -n -1 | rg '^russell\W*(\d+).*' -r '$1' | xargs kill
}

function killSlack {
    PROGRAM=slack
    ps -aux | rg -i $PROGRAM | head -n -1 | rg '^russell\W*(\d+).*' -r '$1' | xargs kill
}

# Page colored ripgrep output
function rgl {
    rg $1 --color=always --heading --line-number | less
}

######################
# Done
######################
col_echo "Done ..." 3
