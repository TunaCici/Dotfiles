# Customization: prompt
PS1="%F{green}%n%f%F{green}@%f%F{green}%m%f:%F{magenta}%~%f$ "
export CLICOLOR=1

# Initialization: VSCode
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Initialization: GPG
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# Alias: exa-ls
alias ls='exa' # ls
alias ll='exa -lbGF --git' # long list
alias la='exa -lha --time-style=iso --git --color-scale' # all list
alias lx='exa -lha@ --time-style=iso --git --color-scale' # all + extended list
alias lt='exa --tree --level=1' # tree
alias ltt='exa --tree --level=2' # tree
alias lttt='exa --tree --level=3' # tree

# Extension: zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh