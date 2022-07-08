# IceWM

## Install an AUR Helper and a graphical package installer

```
sudo pacman -S git
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S pamac-aur
```

## Installing bluetooth support

```
sudo pacman -S bluez pulseaudio-bluetooth
yay -S bluez-utils-compat #That package contains deprecated tools that I need to make my USB-Dongle work. If you don't need them, just install **bluez-utils** via pacman
sudo systemctl enable --now bluetooth
```

## Mount secondary disk in fstab

```
sudo blkid #Show and copy the UUID of my secondary disk
sudo vim /etc/fstab
```
> #Data  
> UUID=107b1979-e8ed-466d-bb10-15e72f7dd2ae       /run/media/rcandau/data         ext4          defaults 0 2  

## Application 

```
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
```

- arch-update (AUR) --> https://github.com/Antiz96/arch-update
- bluemail (AUR)
- ckb-next (AUR) **Only for my Desktop PC to configure my Corsair Keyboard. Settings --> (Last blue : 26, 95, 180)**
- ddgr
- discord
- glow
- hexchat
- keepassxc
- vlc
- gparted
- onlyoffice-bin (AUR)
- openresolv **Only for my Laptop in order to connect to my VPN**
- firefox
- pacman-contrib
- spotify (AUR)
- steam
- virtualbox
- virt-viewer
- imagewriter (AUR)
- timeshift (AUR)
- pa-applet-git (AUR)
- mkinitcpio-numlock (AUR) **Then add the "numlock" hook in /etc/mkinitcpio.conf between "autodetect" and "modconf" and then** `sudo mkinitcpio -p linux`
- tmux
- dmenu
- zathura
- zathura-pdf-poppler
- mlocate
- htop
- neofetch
- wakeonlan (AUR)
- wireguard-tools **Only for my Laptop in order to connect to my VPN**

## Theme

- Shell : Orchis-dark-compact - https://www.gnome-look.org/p/1357889/
- Icon : Tela-Circle-blue - https://www.gnome-look.org/p/1359276/
- Cursor : McMojave cursors - https://www.opendesktop.org/s/Gnome/p/1355701/

## Configuration

**Warning : "/home/rcandau" is hard-coded in the "~/.icewm/keys" file (Lock Screen Shortcut)**  
**Change it accordingly to your username**  

### IceWM configuration

- For regular computers :  

```
mkdir -p ~/.icewm && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/IceWM/icewm.zip -O && unzip icewm.zip -d ~/.icewm/ && chmod +x ~/.icewm/startup && rm -f icewm.zip
```
**Remember to uncomment the correct "Display resolution" line in the "~/.icewm/startup" script depending on the machine (First Line = Desktop | Second Line = Laptop)**  
**Remember to uncomment the CKB-Next command for Desktop PC (Corsair Keyboard)**  

- For Raspberry Pi :  

```
mkdir -p ~/.icewm && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/IceWM/icewm-rpi.zip -O && unzip icewm-rpi.zip -d ~/.icewm/ && chmod +x ~/.icewm/startup && rm -f icewm-rpi.zip
```

## Add touchpad click and navigation (Only for laptop)

```
sudo curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/IceWM/90-touchpad.conf -o /etc/X11/xorg.conf.d/90-touchpad.conf
```

## Dock (plank)

```
sudo sed -i "s/Icon=org.xfce.screenshooter/Icon=applets-screenshooter/g" /usr/share/applications/xfce4-screenshooter.desktop
sudo sed -i "s/Icon=system-software-install/Icon=pamac/g" /usr/share/applications/org.manjaro.pamac.manager.desktop
```

- firefox
- terminal
- spotify
- bluemail
- thunar
- mousepad 
- onlyoffice 
- keepassxc
- steam
- discord
- hexchat
- virtualbox
- screenshot
- pamac
- Arch Update
- Power

## Autoconnect to bluetooth headphones

```
bluetoothctl trust 38:18:4C:E9:85:B4
sudo vi /etc/pulse/default.pa
```
> [...]  
> #Automatically switch to newly-connected devices  
> load-module module-switch-on-connect  

### Dotfiles

```
curl https://raw.githubusercontent.com/Antiz96/Linux-Configuration/main/Dotfiles/General/bashrc_Arch.txt -o ~/.bashrc
curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/General/tmux.conf -o ~/.tmux.conf
mkdir -p ~/.config/zathura/ && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/General/zathurarc -o ~/.config/zathura/zathurarc && xdg-mime default org.pwmt.zathura.desktop application/pdf
mkdir -p ~/.local/share/applications && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/IceWM/power.desktop -o ~/.local/share/applications/power.desktop
mkdir -p ~/.config/xfce4/terminal && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/IceWM/terminalrc -o ~/.config/xfce4/terminal/terminalrc
mkdir -p ~/.config/gsimplecal/ && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/IceWM/config -o ~/.config/gsimplecal/config
sudo curl https://raw.githubusercontent.com/Antiz96/Linux-Configuration/main/Dotfiles/IceWM/picom.conf -o /etc/xdg/picom.conf
source ~/.bashrc
```

## Keyboard Shortcuts

- Super = Open Application Menu
- Super + A = Open Dmenu App Finder/Launcher
- Super + F = Switch size of windows (Maximize/Minimize)
- Super + D = Close the window
- Super + E = Thunar
- Super + C = Calculator
- Super + M = Display the desktop
- Super + T = Terminal
- Super + L = Lock the screen
- Super + V = Tile opened windows vertically
- Super + H = Iconifie active window
- Super + Esc = Open the logout menu
- Super + F1 = Switch to workspace1
- Super + F2 = Switch to workspace2
- Super + F3 = Switch to workspace3
- Super + F4 = Switch to workspace4
- Super + TAB = Switch to next workspace