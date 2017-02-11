#! env zsh
CONFIG_DIR=".qin_conf"
CONFIG_REPO="https://github.com/quentinchen727/zsh_tmux_vim_repo.git"

# Download and create links to my configurations
cd
git clone $CONFIG_REPO $CONFIG_DIR
ln -sf ~/$CONFIG_DIR/vimrc ~/.vimrc
ln -sf ~/$CONFIG_DIR/tmux.conf ~/.tmux.conf
ln -sf ~/$CONFIG_DIR/Zeus.zsh ~/.oh-my-zsh/custom/Zeus.zsh

# Create link to temporary zsh file
touch sisyphus.zsh
ln -sf ~/sisyphus.zsh ~/.oh-my-zsh/custom/sisyphus.zsh
