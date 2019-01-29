# Welcome to amiller27's dotfiles!

---

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
