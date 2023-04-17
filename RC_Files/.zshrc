# Customization: prompt
PS1="%F{green}%n%f%F{green}@%f%F{green}%m%f:%F{magenta}%~%f$ "
export CLICOLOR=1

# Initialization: VSCode
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PATH="/usr/share/code/bin:$PATH"
fi

# Initialization: GPG
if ! gpgconf --list-dirs agent-socket >/dev/null 2>&1; then
  gpgconf --launch gpg-agent
fi

GPG_TTY=$(tty)
export GPG_TTY

# Alias: exa-ls
alias ls='exa' # ls
alias ll='exa -lbGF' # long list
alias la='exa -lha --time-style=iso --color-scale' # all list
alias lx='exa -lha@ --time-style=iso --color-scale' # all + extended list
alias lt='exa --tree --level=1' # tree
alias ltt='exa --tree --level=2' # tree
alias lttt='exa --tree --level=3' # tree

# Extension: zsh-syntax-highlighting
if [[ "$OSTYPE" == "darwin"* ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Extension: zsh-autosuggestions
if [[ "$OSTYPE" == "darwin"* ]]; then
	source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
