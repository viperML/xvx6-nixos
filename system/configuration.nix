{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Karachi";
  system.stateVersion = "22.05";
  sound.enable = true;

  networking = {
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      enable = true;
    };

    dhcpcd.extraConfig = "nohook resolv.conf";
    nameservers = ["127.0.0.1" "::1"];
    interfaces.enp0s25.useDHCP = true;
    resolvconf.enable = false;
    hostName = "ephemeral";
    useDHCP = true;
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  fonts = {
    fontconfig = {
      useEmbeddedBitmaps = true;
      allowBitmaps = true;
    };

    fontDir.enable = true;
    fonts = with pkgs; [scientifica];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    initrd.availableKernelModules = ["ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
    initrd.kernelModules = ["radeon"];
  };

  services = {
    xserver = {
      displayManager = {
        defaultSession = "none+berry";
        sddm.enable = true;
      };

      windowManager.berry = {enable = true;};
      videoDrivers = ["radeon"];
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dnscrypt-proxy2 = {
      enable = true;
      settings.sources = {
        public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];

          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        rocm-opencl-runtime
        rocm-opencl-icd
        libvdpau-va-gl
        vaapiVdpau
      ];
    };

    cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };

  security = {
    doas = {enable = true;};
    rtkit.enable = true;
    sudo.enable = false;
  };

  users.users.agir = {
    packages = with pkgs; [
      ((emacsPackagesFor emacsGit).emacsWithPackages (emacs28Packages: [
        emacs28Packages.vterm
      ]))

      alejandra
      firefox
      sxhkd
      git
    ];

    extraGroups = ["wheel"];
    isNormalUser = true;
  };
}