# Home - manager
{pkgs,...}:
  {
    home-manager.users.lukaszpe = { pkgs, ... }: {
    home.stateVersion = "23.05";
    home.packages = [  ];
    programs.zsh = {
      enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch";
        susu="sudo -i --preserve-env=HOME";
        gn="cd /home/lukaszpe/Dokumenty/Obsidian/notatki";
        gg="gn && git pull";
        pull="git pull";
      ww="git add . && git commit -a --allow-empty-message -m '' && git push; exit";
      wy="git add . && git commit -a --allow-empty-message -m '' && git push";
      };
      initExtra=''
      clne;
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      #Klawisze
        bindkey  '^[[H'   beginning-of-line
        bindkey  '^[[F'   end-of-line
        bindkey  '^[[3~'  delete-char
        bindkey  '^[[2~'  overwrite-mode
        bindkey  ';5D'  backward-word
        bindkey  ';5C'  forward-word
        bindkey  '^H'  backward-delete-word
        bindkey  '5~'  kill-word
        bindkey  '^[[5~'  up-line-or-history
        bindkey  '^[[6~'  down-line-or-history
      '';
      zplug={
        enable = true;
        plugins=[{
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }];
      };
    };
  };
}