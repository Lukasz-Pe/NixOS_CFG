# Home - manager
{pkgs,...}:
  {
    home-manager.users.lukaszpe = { pkgs, ... }: {
    home.stateVersion = "23.05";
    home.packages = [  ];
    };
    programs.zsh = {
  enable = true;
  shellAliases = {
    update = "sudo nixos-rebuild switch";
    susu="sudo -i --preserve-env=HOME"
    gn="cd /home/lukaszpe/Dokumenty/Obsidian/notatki"
    gg="gn && git pull"
    pull="git pull"
     ww="git add . && git commit -a --allow-empty-message -m '' && git push; exit"
     wy="git add . && git commit -a --allow-empty-message -m '' && git push"
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
};
  }