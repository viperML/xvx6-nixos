### muh nixos configuration
#### introduction
muh nixos configuration(TM) now featuring:
  - `hardware-configuration.nix` now 10% better.
  - `configuration.nix`
  - `home-manager` the first of its kind.
  
now with -100% guarantee.

#### installation
while booted into a stable nixos live usb, make sure that you have:
- disk partitioned and mounted (check nixos manual)
- internet connection

once you've partitioned your disks and mounted your disks, run the following commands:
```bash
sudo -i # get root privileges
nix-shell -p nixFlakes nixUnstable # get flakes and unstable channel support
mkdir -p /mnt/etc
cd /mnt/etc
git clone https://github.com/xvx6/nixos --depth 1
cd nixos
nix build --extra-experimental-features 'nix-command flakes' '.#nixosConfigurations.ephemeral.config.system.build.toplevel' && nixos-install --system ./result # You'll be prompted for password
nixos-enter --root /mnt
passwd agir # or replace configuration.nix's users.users.agir with your own username
exit
reboot
```

I showed you my nixos config, pls respond.
