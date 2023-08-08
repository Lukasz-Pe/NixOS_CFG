# Home - manager
{pkgs,...}:
  {
    home-manager.users.lukaszpe = { pkgs, ... }: {
    home.stateVersion = "23.05";
    home.packages = [  ];
    };
  }