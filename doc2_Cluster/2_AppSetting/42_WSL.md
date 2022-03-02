---
sort: 42
---

# Windows Subsystem for Linux

## Enable BIOS & windows setting
- Enable Virtual Techology in BIOS
- Win Setting: Control Panel --> Program --> Turn Windows features on or off --> Windows Subsystem for Linux

## Install Unbutu
open Powershell:
wsl --list --online
wsl --install -d openSUSE-42
wsl --install -d SLES-12


## Use
- Access a folder: cd /mnt/d/folder