# i3

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

- arch-update (AUR) --> https://github.com/Antiz96/arch-update `systemctl --user enable --now arch-update.timer`
- autotiling (AUR)
- bluemail (AUR)
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
- wireguard-tools **Only for my Laptop in order to connect to my VPN**
- zaman (AUR) --> https://github.com/Antiz96/zaman

## Theme

- Shell : Orchis-dark-compact - https://www.gnome-look.org/p/1357889/
- Icon : Tela-Circle-Blue - https://www.gnome-look.org/p/1359276/
- Cursor : McMojave cursors - https://www.opendesktop.org/s/Gnome/p/1355701/

## Configuration

### i3 configuration

```
mkdir -p ~/.config/i3 && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/i3/config -o ~/.i3/config/ && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/i3/lock.png -o ~/.i3/config/ && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/i3/wallpaper.jpg -o ~/.i3/config/
```
**Remember to uncomment the correct "Display resolution" line in the "~/.config/i3/config" file depending on the machine (First Line = Desktop | Second Line = Laptop)**  

### Polybar configuration

```
mkdir -p ~/.config/tint2 && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/i3/tint2rc -o ~/.config/tint2/
```

## Add touchpad click and navigation (Only for laptop)

```
sudo curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/General/90-touchpad.conf -o /etc/X11/xorg.conf.d/90-touchpad.conf
```

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
mkdir -p ~/.config/xfce4/terminal && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/i3/terminalrc -o ~/.config/xfce4/terminal/terminalrc
mkdir -p ~/.config/gsimplecal/ && curl https://raw.githubusercontent.com/Antiz96/Linux-Customisation/main/Dotfiles/i3/config -o ~/.config/gsimplecal/config
sudo curl https://raw.githubusercontent.com/Antiz96/Linux-Configuration/main/Dotfiles/i3/picom.conf -o /etc/xdg/picom.conf
source ~/.bashrc
```

## Keyboard Shortcuts

- Super + A = Open Dmenu App Finder/Launcher
- Super + F = Switch between tabbed and split layout
- Super + D = Close the window
- Super + E = Thunar
- Super + C = Calculator
- Super + T = Terminal
- Super + B = Firefox
- Super + L = Lock the screen
- Super + H = Split horizontally (default mode)
- Super + V = Split vertically
- Super + G = Switch tiling layout of opened windows (vertical/horizontal)
- Super + S = Toggle sticky window
- Super + Shift + Up = Move window to primary monitor
- Super + Shift + Right = Move window to right monitor
- Super + Shift + Left = Move window to left monitor
- Super + Esc = Open the power menu
- Super + F1 = Switch to workspace1
- Super + F2 = Switch to workspace2
- Super + F3 = Switch to workspace3
- Super + F4 = Switch to workspace4
- Super + Tab = Switch to next workspace