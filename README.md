# Credits

All credit for this work goes to Whiskerz007.  Check the base repo at https://github.com/whiskerz007/proxmox_hassio_lxc

# Node Red in Proxmox LXC container

Many benefits can be gained by using a LXC container compared to a VM. The resources needed to run a LXC container are less than running a VM. Modifing the resouces assigned to the LXC container can be done without having to reboot the container. The serial devices connected to Proxmox can be shared with multiple LXC containers simulatenously.

## Usage

***Note:*** _Before using this repo, make sure Proxmox is up to date._

To create a new LXC container on Proxmox and setup Hass.io to run inside of it, run the following in a SSH connection or the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/MarcJenningsUK/proxmox_hassio_lxc/master/Node%20Red%20Setup/create_container.sh)"
```

## Default console login credentials

```
Username: root
Password: nodered
```
