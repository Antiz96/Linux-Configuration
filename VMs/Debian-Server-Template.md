# Debian Server Template

Just a quick reminder on how I install a minimal Debian Server environment to work with.  
It aims to be turned as a template.  

## Base Install

I basically follow each installation steps normally with the following exceptions :

- I use a different partition scheme depending on if the context is personal or professional (see : [Partition scheme](https://github.com/Antiz96/Linux-Configuration/blob/main/Debian-Server-Template.md#partition-scheme))
- I don't check anything during the **Software selection** step so I get a minimal installation. I install useful packages after the installation instead (see [Install useful packages](https://github.com/Antiz96/Linux-Configuration/blob/main/Debian-Server-Template.md#install-useful-packages))
- I don't create any user during the installation process. Indeed, this will be handled by an ansible playbook. I do create a "ansible" user for that purpose afterward instead (see [Create and configure the ansible user](https://github.com/Antiz96/Linux-Configuration/blob/main/Debian-Server-Template.md#create-and-configure-the-ansible-user))

### Partition scheme

- Personal context :    
  
> EFI partition mounted on /boot/EFI --> 550M - ESP    
> Swap partition --> 4G - SWAP  
> Root partition mounted on / --> Left free space - EXT4 (0% Reserved block)  
  
- Professional context :  
  
> EFI partition mounted on /boot --> 550M - ESP   
> Swap partition --> 4G - SWAP  
> Root partition --> Left free space - XFS - LVM  
> > / --> 3G  
> > /home --> 2G  
> > /tmp --> 2G  
> > /opt --> 2G  
> > /usr --> 4G  
> > /var --> 1G  
> > /var/log --> 4G  

### Install useful packages

```
apt update && apt install sudo vim man bash-completion openssh-server dnsutils traceroute rsync zip unzip diffutils firewalld mlocate htop curl openssl telnet chronyd parted wget postfix
```

### Configure various things 

#### Enable ssh

```
systemctl enable --now ssh
```

#### Secure SSH connexion

```
vi /etc/ssh/sshd_config
```
> [...]  
> Port **"X"** #Change the default SSH port (where "X" is the port you want to set)  
> [...]  
> PermitRootLogin no #Disable the SSH connexion for the root account  
> [...]  
> PasswordAuthentication no #Disable SSH connexions via password  
> AuthenticationMethods publickey #Authorize only SSH connexions via publickey  
> [...]  

```
systemctl restart ssh #Restart the SSH daemon to apply changes
```

#### Configure the firewall

```
systemctl enable firewalld #Autostart the firewall at boot.
firewall-cmd --remove-service="ssh" --permanent #Remove the opened ssh port by default as my PC doesn't run a ssh server.
firewall-cmd --remove-service="dhcpv6-client" --permanent #Remove the opened DHCPV6-client port by default as I don't use it.
firewall-cmd --add-port=X/tcp --permanent #Open the port we've set for SSH (replace "X" by the port)
firewall-cmd --reload #Apply changes
```

#### Install qemu-guest-agent (for promox)

```
apt install qemu-guest-agent
systemctl enable --now qemu-guest-agent
```

### Create and configure the ansible user

```
useradd -m ansible #Create the ansible user
vim /etc/sudoers.d/ansible #Make the ansible user a sudoer
```
> ansible ALL=(ALL) NOPASSWD: ALL  

```
touch /home/ansible/.ssh/authorized_keys && chmod 644 /home/ansible/.ssh/authorized_keys && chown ansible: /home/ansible/.ssh/authorized_keys #Create the authorized_keys file for the user ansible
vim /home/ansible/.ssh/authorized_keys #Insert the ansible master server's SSH public key in it (ansible@ansible-server)
```
> Copy the ansible master server's SSH public key here (ansible@ansible-server)  

## Reboot

```
reboot
```