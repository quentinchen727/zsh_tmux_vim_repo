# instruction
*************
Prerequisite:
*************
1. yum install zsh # install zsh
2. yum install git # install git
3. Export http_proxy=PROXY_URL
4. Export https_proxy=PROXY_URL
5. git config --global http.proxy PROXY_URL
6. sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # install oh-my-zsh
7. sh -c "$culr -fsSL https://raw.githubusercontent.com/quentinchen727/zsh_tmux_vim_repo/master/tools/install.sh)" # install vim, zsh, tmux config
8. Install vim-plug
9. Load vim, and run :PluginInstall
10. Install support tools and python-devel/python34-devel for YCM, then run
    ./install.py in YCM
11. Install the_silver_searcher for ack and ctrlP.

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
