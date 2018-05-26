##################################
# .bash_profile
##################################

# By Russell Bentley
# August 2016

# I treat this as my login script
# Note, my tmux conf specifies that zsh is the defualt shell.

echo "Sourcing bash_profile"

# Now we run zsh
exec /bin/zsh --login

# Vestigial line, but if zsh didn't work? would this even execute? 
# ...
# I don't know
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

export PATH="$HOME/.cargo/bin:$PATH"
