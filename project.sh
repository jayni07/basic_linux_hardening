#!/bin/bash


echo "Choose a security level:"
echo "a) Minimum"
echo "b) High"
echo "c) superhigh"

read -p "Enter your choice: " choice

case $choice in
  a)
    echo "Enabling minimum security..."
    #-----updating all packages-----
    echo "--Updating all packages--"
    apt -get update
    sudo  apt-get update -y

    #---disabling unnecesarry services---
    echo "--Disabling unncessary services--"
    sudo systemctl disable bluetooth
    sudo systemctl disable avahi-daemon
    #echo "System needs to be restarted to apply changes. Restart now? (y/n)"
	#read answer
	#if [ "$answer" == "y" ]; then
	    #sudo reboot
	#else
	    #echo "System restart required to apply changes."
	#fi
    #---configuring and setting up firewalls---
    echo "--configuring and setting up firewalls--"
    sudo apt-get install ufw
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw default deny incoming
    sudo ufw enable

    ;;
  b)
    echo "Enabling high security..."
    #-----updating all packages-----
    echo "--Updating all packages--"
    apt -get update
    sudo  apt-get update -y

    #---disabling unnecesarry services---
    echo "--Disabling unncessary services--"
    sudo systemctl disable bluetooth
    sudo systemctl disable avahi-daemon

    #--setup intrusion detection system--
    sudo apt install fail2ban -y

    ;;
  c)
    echo "Enabling super high security..."
    #-----updating all packages-----
    echo "--Updating all packages--"
    apt -get update
    sudo  apt-get update -y

    #---disabling unnecesarry services---
    echo "--Disabling unncessary services--"
    sudo systemctl disable bluetooth
    sudo systemctl disable avahi-daemon

    echo "--Enabling audit logging--"
    #installing auditd package
    sudo apt-get install auditd
    echo "sudo -w /etc/passwd -p wa -k password-file" >> /etc/audit/audit.rules
    echo "sudo -w /etc/shadow -p wa -k password-file" >> /etc/audit/audit.rules
    echo "sudo -w /etc/group -p wa -k group-file" >> /etc/audit/audit.rules
    echo "sudo -w /etc/gshadow -p wa -k group-file" >> /etc/audit/audit.rules
    service auditd reload
    service auditd start
    service auditd status

    ;;
  *)
    echo "Invalid choice, please try again."
    ;;
esac

