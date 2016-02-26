# Setup for clear ubuntu

Just run the following to setup your new installation:
* Clone repository
```bash
git clone git@github.com:karol-gruszczyk/dotfiles.git
cd dotfiles/
```
* Install ansible
```bash
sudo apt-get install -y ansible
```
* Run the playbook
```bash
ansible-playbook -i "localhost," -c local setup.yml
```
