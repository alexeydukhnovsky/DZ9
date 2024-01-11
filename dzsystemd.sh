sudo -i
cat >> /etc/sysconfig/watchlog <<EOF
# Configuration file for my watchlog service
# Place it to /etc/sysconfig
# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log
EOF
cat >> /var/log/watchlog.log <<EOF
Test
Otus
ALERT
qawsed
12345
EOF
cp /vagrant/watchlog.sh /opt/
chmod +x /opt/watchlog.sh
cp /vagrant/watchlog.service /etc/systemd/system/
cat >> /etc/systemd/system/watchlog.timer <<EOF
[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable watchlog.service
systemctl enable watchlog.timer
systemctl start watchlog.service
systemctl start watchlog.timer
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
rm -f /etc/sysconfig/spawn-fcgi
cp /vagrant/spawn-fcgi /etc/sysconfig/
cp /vagrant/spawn-fcgi.service /etc/systemd/system/
systemctl start spawn-fcgi 
cp /vagrant/httpd@.service /etc/systemd/system/
cp /vagrant/first.conf /etc/httpd/conf/
cp /vagrant/second.conf /etc/httpd/conf/
cat >> /etc/sysconfig/httpd-first <<EOF
OPTIONS=-f conf/first.conf
EOF
cat >> /etc/sysconfig/httpd-second <<EOF
OPTIONS=-f conf/second.conf
EOF
systemctl enable httpd@first
systemctl enable httpd@second
systemctl start httpd@first
systemctl start httpd@second
