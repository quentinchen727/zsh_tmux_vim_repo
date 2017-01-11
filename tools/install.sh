#! env zsh
CONFIG_DIR=".zsh_tmux_vim_repo"
CONFIG_REPO="git:"
VIM_DIR=".vim"
VIM_REPO=""
cd
git clone $CONFIG_REPO $CONFIG_DIR
cd $CONFIG_DIR
ln -s vimrc ~/.vimrc
ln -s tmux.conf ~/.tmux.conf
ln -s Zeus.sh .oh-my-zsh/custom/Zeus.sh

#clone vim plugins and bundles
cd ~
git clone $VIM_REPO $VIM_DIR

