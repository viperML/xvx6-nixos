pkgs: {
  extraConfig = {
    url = {
      "git://github.com/" = {
        insteadOf = "github:";
      };
      "git@github.com:" = {
        insteadOf = "gh:";
        pushInsteadOf = ["github:" "git://github.com/"];
      };
    };

    pull = {
      ff = "only";
      rebase = "false";
      default = "simple";
    };

    init.defaultBranch = "master";
  };

  enable = true;
  userName = "xvx6";
  userEmail = "keter@keemail.me";
}
