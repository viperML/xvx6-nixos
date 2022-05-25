### muh nixos configuration
#### introduction
muh nixos configuration(TM) now featuring:
  - `hardware-configuration.nix` now 10% better.
  - `configuration.nix`
  - `home-manager` the first of its kind.
  
now with -100% guarantee.

#### installation
once booted into an unstable nixos live usb obtained from https://releases.nixos.org, make sure that you have:
- disk partitioned and mounted (check nixos manual)
- internet connection

once you've partitioned your disks and mounted your disks, run the following commands:
```bash
sudo -i # get root privileges
mkdir -p /mnt/etc
cd /mnt/etc
git clone https://github.com/xvx6/nixos --depth 1
cd nixos
nixos-install --flake '.#ephemeral'
nixos-enter --root /mnt
passwd sarasa # or replace configuration.nix's users.users.sarasa with your own username
exit
reboot
```

I showed you my nixos config, pls respond.
