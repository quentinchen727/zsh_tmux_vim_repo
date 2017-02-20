#! /bin/bash

#...................................#
# customized configuration for TAAS #
#...................................#

(
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
lab_addrs=$(printf "%s," 20.0.{50,52,60}.{1..255})
LAB_ADDRS=${lab_addrs%,}
NO_PROXY_DOCKER="localhost,127.0.0.1,dockerhub.cisco.com"
NO_PROXY="$NO_PROXY_DOCKER,$LAB_ADDRS"

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

# Install TAAS packages {{{
# lsb is the dependency for chrome
echo "Install Taas-specific packages"
pkgs=(zsh tmux git docker-engine python34 the_silver_searcher nodejs lsb)
for pkg in ${pkgs[*]}
do
  ecmd yum -y install $pkg
done

echo "Install Chrome"
ecmd wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
ecmd rpm -i google-chrome-stable_current_x86_64.rpm
ecmd rm google-chrome-stable_current_x86_64.rpm
# }}}

# Docker configuration {{{
echo "Configure Docker"
ecmd mkdir -p /etc/systemd/system/docker.service.d
echo '[Service]
Environment="HTTP_PROXY=http://proxy.esl.cisco.com:80/" "NO_PROXY=$NO_PROXY_DOCKER"
' > /etc/systemd/system/docker.service.d/http-proxy.conf
ecmd systemctl enable docker
ecmd systemctl daemon-reload
ecmd systemctl start docker
# }}}

# Vncserver configuration for root {{{
echo "Configure vncserver for root"
cp /usr/lib/systemd/system/vncserver@.service \
     /etc/systemd/system/vncserver-root@.service
sed -i "/^ExecStart/ s/<USER>/root/" \
     /etc/systemd/system/vncserver-root@.service
sed -i "/^PIDFile/ s:home/<USER>:root:" \
     /etc/systemd/system/vncserver-root@.service
echo "### create vncpasswd under /root/.vnc ###" `date`
echo -e "cisco123\ncisco123\n" | vncpasswd
ecmd ls -l /root/.vnc/

echo "### create xstartup ###" `date`
echo '#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /usr/bin/mate-session ] && exec /usr/bin/mate-session
' > /root/.vnc/xstartup

echo "### verify xstart content ###" `date`
ecmd cat /root/.vnc/xstartup
echo "### xstartup needs execution bit on ###" `date`
ecmd chmod 755 /root/.vnc/xstartup
ecmd ls -l /root/.vnc/
echo "### enable vncserver to auto start with display number <8> ###"
ecmd systemctl enable vncserver-root@:8.service
ecmd systemctl daemon-reload
ecmd systemctl start vncserver-root@:8.service
# }}}

# Qins customized configuration {{{
echo "Qin's special configuration"
# Install oh-my-zsh; delete "env zsh" to avoid entering zsh
ecmd sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/env zsh/ d')"

# Install vim, zsh, tmux config
ecmd sh -c "$(curl -fsSL https://raw.githubusercontent.com/quentinchen727/zsh_tmux_vim_repo/master/tools/install.sh)"

# Install vim-plug
ecmd curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install YouCompleteMe
ecmd yum install python-devel python34-devel automake gcc-c++ cmake
echo "gcc and kernel-devel have already been installed"

echo
echo "************** manually tuning instructions **************"
echo "1.source /etc/environment to get proxy setting into effect"
echo "  In order to install vim plugin, launch vim and execute:"
echo "              :PluginInstall                             "
echo "  After that, cd into ~/.vim/bundle/YouCompleteMe        "
echo "             ./install.py --tern-completer                "

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
) 2>&1 | /usr/bin/tee /root/taas_install.log
