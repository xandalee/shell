#!/bin/bash

# This script is running to build ss server.

set -x

ss_pass="123456"
ss_port=1080

# change the port that sshd listens on.
# password authentication is disabled for root.

echo "Port 8787" >> /etc/ssh/sshd_config
echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config
systemctl restart sshd.service
firewall-cmd --remove-service=ssh --permanent
firewall-cmd --add-port=8787/tcp --permanent
firewall-cmd --reload


yum install -y expect
wget --no-check-certificate -O /tmp/shadowsocks.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
cd /tmp
cat <<EOF > expect_build
#!/usr/bin/expect -f
set timeout -1

set password $ss_pass
set port $ss_port
set cipher 7

spawn bash /tmp/shadowsocks.sh
expect {
        "Default password:" {send "\$password\r";exp_continue}
        "Default port:" {send "\$port\r";exp_continue}
        "Which cipher" {send "\$cipher\r";exp_continue}
        "any key" {send "\r"}
}
expect eof
EOF
chmod +x expect_build
./expect_build

# appex
# wget --no-check-certificate -O rskernel.sh https://raw.githubusercontent.com/uxh/shadowsocks_bash/master/rskernel.sh && bash rskernel.sh
# yum install net-tools -y && wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh && bash appex.sh install

# bbr
# wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
