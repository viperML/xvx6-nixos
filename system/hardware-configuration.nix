# when you use hardware-configuration for just filesystems:
# STONKS
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6e96fa1b-02b0-4c92-9fa4-89269243df58";
      fsType = "xfs";
    };

    "/storage" = {
      device = "/dev/disk/by-uuid/1c1f5f3c-83c1-4979-ab86-ce8f8fcd5ab5";
      fsType = "xfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/919C-DCA0";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/0ad9eaa1-64d7-4b10-ad81-32326ae3651e";
      fsType = "xfs";
    };
  };
}
