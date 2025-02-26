# Created by newuser for 5.9

#Start the SSH agenti
eval "$(ssh-agent -s)" > /dev/null
#Set Git to always use my SSH Config
#export GIT_SSH_COMMAND="ssh -F ~/.config/ssh/config"
#Add the SSH key
ssh-add ~/.config/ssh/id_rsa_github 2> /dev/null
