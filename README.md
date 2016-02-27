# Setup for clear ubuntu

### Requirements
* Git
```bash
sudo apt-get update
sudo apt-get install git
```

* Ansible
```bash
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

### Setup
Just run the following to setup your new installation:

* Clone repository
```bash
git clone https://github.com/karol-gruszczyk/dotfiles.git
cd dotfiles/
```

* Run the playbook
```bash
ansible-playbook -i "localhost," -c local setup.yml --ask-sudo
```
