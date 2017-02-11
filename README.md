# instruction
*************
Prerequisite:
*************
1. yum install zsh # install zsh
2. yum install git # install git
3. export http_proxy=PROXY_URL
4. export https_proxy=PROXY_URL
5. sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # install oh-my-zsh
6. sh -c "$(curl -fsSL https://raw.githubusercontent.com/quentinchen727/zsh_tmux_vim_repo/master/tools/install.sh)" # install vim, zsh, tmux config
7. # Install vim-plug
   curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
8. # Load vim, and run :PluginInstall
9. # Install support tools and python-devel/python34-devel for YCM, then run
    ./install.py in YCM
10. # Install the_silver_searcher for ack and ctrlP.
    yum install the_silver_searcher

**************
Note
**************
utf-8 is not needed any more.

Customized files:
.gitconfig: git config file
.tmux.conf: tmux config file
.vimrc: vim config file
.zshrc: geneal zsh config file
Zeus.zsh: general personalized zsh config file
Sysphus.zsh: specific zsh config file, usually for alias

Tuned around the oh-my-zsh file.
