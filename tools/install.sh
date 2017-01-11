#! env zsh
CONFIG_DIR=".zsh_tmux_vim_repo"
CONFIG_REPO="https://github.com/quentinchen727/zsh_tmux_vim_repo.git"
VIM_DIR=".vim"
VIM_REPO="https://github.com/quentinchen727/Vim_plugins_repo.git"
cd
git clone $CONFIG_REPO $CONFIG_DIR
ln -sf ~/$CONFIG_DIR/vimrc ~/.vimrc
ln -sf ~/$CONFIG_DIR/tmux.conf ~/.tmux.conf
ln -sf ~/$CONFIG_DIR/Zeus.sh ~/.oh-my-zsh/custom/Zeus.sh
touch sisyphus.zsh
ln -sf sisyphus.zsh ~/.oh-my-zsh/custom/sisyphus.zsh

#clone vim plugins and bundles
cd ~
git clone $VIM_REPO $VIM_DIR

