#! /bin/bash

#...................................#
# customized configuration for TAAS #
#...................................#

{
TAAS_HOME=/home/cosben
TAAS_USER=cosben
E_NOT_ROOT=60

if [[ $USER != "root" ]]
then
  echo "Must be root to execute this shell script"
  exit $E_NOT_ROOT
fi

echo "### Running TAAS Configuration ###"
# echo and execute simple command; please donot use with redirect or set
function ecmd() { echo TIME: `date`; echo CMD: "$@"; "$@"; }

# Add global http_proxy configuration {{{
LAB_PROXY=http://171.71.50.129:3128
CISCO_PROXY=http://proxy.esl.cisco.com:80
# lab_addrs=$(printf "%s," 20.0.{50,52,60}.{1..255})
lab_addrs=20.0.50,20.0.52,20.0.60
LAB_ADDRS=${lab_addrs%,}
# private_addrs=$(printf "%s," 10.{0..255}.{0..255}.{0..255})
private_addrs=10.
PRIVATE_ADDRS=${private_addrs%,}
NO_PROXY_DOCKER="localhost,127.0.0.1,dockerhub.cisco.com"
NO_PROXY="$NO_PROXY_DOCKER,$LAB_ADDRS,$PRIVATE_ADDRS"

echo "# Proxy setting
export http_proxy=$CISCO_PROXY
export https_proxy=$CISCO_PROXY
export no_proxy=$NO_PROXY" >> /etc/profile.d/proxy.sh
source /etc/profile.d/proxy.sh
# }}}

# Add the official docker repo {{{
echo "Add docker offical repo"
yum install -y yum-utils
yum-config-manager \
  --add-repo \
  https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo
yum makecache fast
# }}}

# Add the mongodb repo {{{
# single quote to strong quote the text, no shell parsing needed for $releasever
echo "Add Mongodb repo"
# Use quoted docstring to suppress variable substitutions
cat > /etc/yum.repos.d/mongodb-org-3.4.repo <<"EOF"
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF
#}}}

# Install TAAS packages {{{
# lsb is the dependency for chrome
echo "Install Taas-specific packages"
pkgs=(zsh tmux git docker-engine python34 the_silver_searcher nodejs lsb \
  mongodb-org)
for pkg in ${pkgs[*]}
do
  ecmd yum -y install $pkg
done

echo "Install Chrome"
ecmd wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
ecmd rpm -i google-chrome-stable_current_x86_64.rpm
ecmd rm google-chrome-stable_current_x86_64.rpm

echo "Install pip for python34"
wget https://bootstrap.pypa.io/get-pip.py -O - | python3

echo "Install docker-compose"
pip install docker-compose
# }}}

# Docker configuration {{{
echo "Configure Docker"
ecmd mkdir -p /etc/systemd/system/docker.service.d
# Use docstring to accept variable substitutions
cat > /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
[Service]
Environment="HTTP_PROXY=$CISCO_PROXY" "HTTPS_PROXY=$CISCO_PROXY" "NO_PROXY=$NO_PROXY_DOCKER"
EOF
ecmd systemctl enable docker
ecmd systemctl daemon-reload
ecmd systemctl start docker
# }}}

# Vncserver configuration for $TAAS_USER {{{
echo "Configure vncserver for $TAAS_USER"
cp /usr/lib/systemd/system/vncserver@.service \
     /etc/systemd/system/vncserver-$TAAS_USER@.service
sed -i "/^ExecStart/ s/<USER>/$TAAS_USER/" \
     /etc/systemd/system/vncserver-$TAAS_USER@.service
sed -i "/^PIDFile/ s:home/<USER>:$TAAS_USER:" \
     /etc/systemd/system/vncserver-$TAAS_USER@.service
echo "### create vncpasswd under /$TAAS_HOME/.vnc ###" `date`
echo -e "lab123\nlab123\n" | vncpasswd $TAAS_HOME/.vnc/passwd
ecmd ls -l /$TAAS_HOME/.vnc/

echo "### create xstartup ###" `date`
echo '#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /usr/bin/mate-session ] && exec /usr/bin/mate-session
' > /$TAAS_HOME/.vnc/xstartup

echo "### verify xstart content ###" `date`
ecmd cat /$TAAS_HOME/.vnc/xstartup
echo "### xstartup needs execution bit on ###" `date`
ecmd chmod 755 /$TAAS_HOME/.vnc/xstartup
ecmd ls -l /$TAAS_HOME/.vnc/
echo "### enable vncserver to auto start with display number <8> ###"
ecmd systemctl enable vncserver-$TAAS_HOME@:8.service
ecmd systemctl daemon-reload
ecmd systemctl start vncserver-$TAAS_HOME@:8.service
# }}}

# Qins customized configuration {{{
echo "Qin's special configuration"
# Install oh-my-zsh; delete "env zsh" to avoid entering zsh
emcd cd $TAAS_HOME
ecmd sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/env zsh/ d')"

# Install vim, zsh, tmux config
ecmd sh -c "$(curl -fsSL https://raw.githubusercontent.com/quentinchen727/zsh_tmux_vim_repo/master/tools/install.sh)"

# Install vim-plug
ecmd curl -fLo /$TAAS_HOME/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install YouCompleteMe
ecmd yum install python-devel python34-devel automake gcc-c++ cmake
echo "gcc and kernel-devel have already been installed"

# Install jSHint for javascript, js-yaml for yaml, jsonlint for json, and bower
# for frontend package management
ecmd npm install -g jshint
ecmd npm install -g js-yaml
ecmd npm install -g jsonlint
ecmd npm install -g bower

# Install shell lint
ecmd ym install ShellCheck

# Install html lint
yum install tidy

# Install python package flake8 for linting. It combines flake8 and PyFlakes
ecmd pip3 install flake8

# Install vimscript lint
pip3 install vim-vint

echo
echo "************** manually tuning instructions **************"
echo "1.source /etc/environment to get proxy setting into effect"
echo "  In order to install vim plugin, launch vim and execute:"
echo "              :PluginInstall                             "
echo "  After that, cd into ~/.vim/bundle/YouCompleteMe        "
echo "             ./install.py --tern-completer               "
echo "             cd ~/.vim/bundle/tern_for_vim               "
echo "             npm install # to run tern server            "

# }}}

# Network configuration {{{
echo "2. Change the interface configurations in /etc/sysconfig/network-scripts"
echo "   Refer to ifconfig-example"
echo "   After that, issue the following:"
echo "   Release existing IPs: dhclient -r"
echo "   Reboot the interface: ifdown and ifup the interface"
echo "   or ip link set enp_x_x down/up"
# }}}

echo "### End of taas-install steps"
} 2>&1 | /usr/bin/tee /root/taas_install.log
