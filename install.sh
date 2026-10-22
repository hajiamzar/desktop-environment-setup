#!/bin/bash
set -e

# Detect the OS engine
if [ -f /etc/debian_version ]; then
    echo "Distro detected: Debian/Ubuntu family"
    sudo apt update
    sudo apt install -y git ansible

elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
    echo "Distro detected: Fedora/RedHat family"
    sudo dnf install -y git ansible-core

elif [ -f /etc/arch-release ]; then
    echo "Distro detected: Arch Linux family"
    sudo pacman -Sy --noconfirm git ansible

else
    echo "Unsupported distribution. Please install git and ansible manually."
    exit 1
fi

# Execute the universal playbook
ansible-playbook -i hosts local.yml --ask-become-pass
