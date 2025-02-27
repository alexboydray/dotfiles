# Created by newuser for 5.9

#Start the SSH agenti
eval "$(ssh-agent -s)" > /dev/null

#Add the SSH key
ssh-add ~/.config/ssh/id_rsa_github 2> /dev/null

#Env variable to find starship theme
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

#Initialize starship
eval "$(starship init zsh)"
