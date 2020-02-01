LXC=$(whiptail --title "Radio list example" --radiolist \
"Choose user's permissions" 20 78 4 \
"HomeAssistant" "Install Home Assistant (formerly Hass.io)" ON \
"NodeRed" "Install Node Red" OFF  3>&1 1>&2 2>&3)

if [ $LXC == 'HomeAssistant' ]
then
  echo You chose to install home assistant.
  bash -c "$(wget -qLO - https://github.com/whiskerz007/proxmox_hassio_lxc/raw/master/create_container.sh)"
elif [ $LXC == 'NodeRed' ]
then
  echo You chose to install Node Red.
  bash -c "$(wget -qLO - https://github.com/MarcJenningsUK/proxmox_nodered_lxc/raw/master/create_container.sh)"
else
  echo Quitting.
fi


