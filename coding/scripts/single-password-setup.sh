#!/usr/bin/expect -f
# Get password once
stty -echo
send_user "Enter your password: "
expect_user -re "(.*)\n"
send_user "\n"
stty echo
set password $expect_out(1,string)

# Add SSH keys with full paths
spawn ssh-add /home/dfg/.ssh/linode
expect "passphrase"
send "$password\r"
expect eof

spawn ssh-add /home/dfg/.ssh/github
expect "passphrase" 
send "$password\r"
expect eof

# Handle sudo commands
spawn sudo bash -c {
    if ! ping -c 1 github.com &>/dev/null; then
        echo "GitHub DNS resolution issue detected. Adding GitHub to hosts file..."
        if ! grep -q "github.com" /etc/hosts; then
            echo "140.82.121.4 github.com" >> /etc/hosts
            echo "GitHub added to hosts file."
        fi
    fi
    /usr/local/bin/start-docker.sh
}
expect "password"
send "$password\r"
expect eof
