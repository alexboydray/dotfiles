#############################################################################
############################## SSH Agent ####################################
#############################################################################

#Start the SSH agenti
eval "$(ssh-agent -s)" > /dev/null

#Add the SSH key
ssh-add ~/.config/ssh/id_rsa_github 2> /dev/null

############################################################################
############################# Zinit Config #################################
############################################################################

# Declare Zinit as an associative array
declare -A ZINIT

 # Set custom directories
ZINIT[BIN_DIR]="$HOME/.config/zinit/bin"
ZINIT[HOME_DIR]="$HOME/.config/zinit"
ZINIT[PLUGINS_DIR]="$ZINIT[HOME_DIR]/plugins"
ZINIT[COMPLETIONS_DIR]="$ZINIT[HOME_DIR]/completions"
ZINIT[SNIPPETS_DIR]="$ZINIT[HOME_DIR]/snippets"

 # Ensure Zinit is installed in the correct location
if [ ! -d "$ZINIT[HOME_DIR]" ] || [ -z "$(ls -A "$ZINIT[HOME_DIR]")" ]; then
   mkdir -p "$ZINIT[HOME_DIR]"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT[HOME_DIR]"
fi
 # Source Zinit from the correct location
source "$ZINIT[HOME_DIR]/zinit.zsh" 

#Add Zinit Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

##########################################################################
######################### Zinit Plugin Configs ###########################
##########################################################################

#zsh-autosuggestions keybindings
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#zsh-autosuggestions history
HISTSIZE=5000
HISTFILE=~/.config/zinit/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#zsh-autosuggestions completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

##########################################################################
######################### Starship Config ################################
##########################################################################

#Env variable to find starship theme
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

#Initialize starship
eval "$(starship init zsh)"


##########################################################################
############################## Aliases ###################################
##########################################################################

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias c='clear'
alias cls='clear'
alias ff='fastfetch'
#alias ls='eza -a --icons=always'
#alias ll='eza -al --icons=always'
#alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias wifi='nmtui'

# -----------------------------------------------------
# ML4W Apps
# -----------------------------------------------------
alias ml4w-calendar='flatpak run com.ml4w.calendar'

# -----------------------------------------------------
# Window Managers
# -----------------------------------------------------

alias Qtile='startx'
# Hyprland with Hyprland

# -----------------------------------------------------
# Scripts
# -----------------------------------------------------
alias ascii='~/.config/ml4w/scripts/figlet.sh'

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# -----------------------------------------------------
# Qtile
# -----------------------------------------------------
alias res1='xrandr --output DisplayPort-0 --mode 2560x1440 --rate 120'
alias res2='xrandr --output DisplayPort-0 --mode 1920x1080 --rate 120'
alias setkb='setxkbmap de;echo "Keyboard set back to de."'



