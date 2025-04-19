export PATH="$HOME/dotfiles/bin:$PATH"

source "$HOME/dotfiles/zsh/env.zsh"
source "$HOME/dotfiles/zsh/aliases.zsh"
source "$HOME/dotfiles/zsh/functions.zsh"

# homebrew

export PATH="/opt/homebrew/bin:$PATH"


#rbenv

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


#starship

eval "$(starship init zsh)"

###########################################################################

# アピアランス

#lsコマンドのカラー表示
export CLICOLOR=1


#ターミナルの色数
export TERM=xterm-256color


# カラーリストを表示
colorlist() {
	for color in {000..015}; do
		print -nP "%F{$color}$color %f"
	done
	printf "\n"
	for color in {016..255}; do
		print -nP "%F{$color}$color %f"
		if [ $(($((color-16))%6)) -eq 5 ]; then
			printf "\n"
		fi
	done
}

###########################################################################

# プロンプト

# export PS1='%F{123}[%n]%f %F{004}%~ %f
# %# '

# autoload -Uz colors
# colors
# # PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
# PROMPT2="%F{154}%_> %f" # パイプなどの改行
# SPROMPT="%F{202}correct: %R -> %r [nyae]? %f" # コマンドが間違っているときの候補
# # RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

###########################################################################

# 補完

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
# bindkey '^R' history-incremental-pattern-search-backward

###########################################################################

# オプション

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

###########################################################################

# エイリアス

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias reload='source ~/.zshrc'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# アプリの起動
alias brave="open -a 'Brave Browser'"

###########################################################################

# プロジェクトの作成
mkproject() {
  local name=$1
  mkdir -p ~/Projects/"$name"
  cd ~/Projects/"$name" || return
  git init
  npm init -y
  echo "# $name" > README.md
  echo "node_modules/" > .gitignore
  code .
}
