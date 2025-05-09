autoload -U compinit
compinit

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]
then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Install eza using nix
if ! command -v eza &> /dev/null; then
    nix profile install nixpkgs#eza
fi

# Alias
alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias lt="eza --tree --icons"
alias l="eza -l --icons"
alias zs="code ~/.zshrc"
alias ga="git add ."
alias gp="git push"
alias gpl="git pull --prune"
alias grebase="git checkout main && git pull -p && git checkout - && git rebase main"
alias gcaf="git commit --amend --no-edit && git push --force"

### begin zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugins
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use

zinit wait lucid for \
    OMZ::lib/git.zsh \
    OMZ::plugins/git/git.plugin.zsh \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions

zstyle ':prompt:pure:prompt:success' color green

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }
