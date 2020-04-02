# Welcome to amiller27's dotfiles!

This repo contains my dotfiles, as well as setup for other programs I want installed on computers I use.  It's all managed with Ansible and GNU stow.

To install _everything_ from scratch:

```bash
git clone https://github.com/amiller27/dotfiles
cd dotfiles
./get_ansible.sh
```

And then run an Ansible playbook for the level of stuff you want.  All the playbooks are in `dotfiles/ansible`, each one installing a different amount of stuff.  For example, if you want everything installed, run:

```bash
cd ansible
./desktop-full.yaml
```

## Instructions for things that I'm not putting in Ansible

### Default gnome theme

From <https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-install-vanilla-gnome-on-ubuntu-18-04/>

```bash
sudo apt install gnome-session
sudo update-alternatives --config gdm3.css
```

Then select "GNOME on Xorg" as session type at gdm login screen

### GDM monitor config

From <https://askubuntu.com/questions/11738/force-gdm-login-screen-to-the-primary-monitor>

```bash
sudo cp ~/.config/monitors.xml ~gdm/.config/
```

### Zotero

See <https://tomsaunders.co.nz/zotero-with-google-drive/>

Then install Better Bibtex too

### Set keyboard shortcuts

This one is self-explanatory

### Gnome-shell extensions

See gnome-shell-extensions.md

### Redshift

Need to start manually and turn on autostart, and need to enable location services in settings

### PB for desktop

Download deb, no ppa

<https://sidneys.github.io/pb-for-desktop/#download>

### Gnome-shell stuff

Appearance > Icons to Numix

Top Bar > Date, Seconds on

### rEFInd

Theme from [here](https://github.com/andersfischernielsen/rEFInd-minimal-black)

Copy refind.conf to `/boot/efi/EFI/refind/refind.conf`

### Discord

In-app option doesn't start on login, need to go to ubuntu startup applications menu

### Hibernate

Follow steps [here](https://askubuntu.com/questions/1053134/hibernation-in-18-04)

Can add kernel parameters for rEFInd in `/boot/refind_linux.conf`

### See `ansible/packages/non-deb`
