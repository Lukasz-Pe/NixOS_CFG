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
        setopt interactive_comments bashautolist nobeep nomenucomplete noautolist
        ## Keybindings section
        bindkey -e
        bindkey '^[[7~' beginning-of-line                   # Home key
        bindkey '^[[H' beginning-of-line                    # Home key
        # [Home] - Go to beginning of line
        if [[ "''${terminfo[khome]}" != "" ]]; then
          bindkey "''${terminfo[khome]}" beginning-of-line
        fi
        bindkey '^[[8~' end-of-line                         # End key
        bindkey '^[[F' end-of-line                          # End key
        # [End] - Go to end of line
        if [[ "''${terminfo[kend]}" != "" ]]; then
        bindkey "''${terminfo[kend]}" end-of-line
        fi
        bindkey '^[[2~' overwrite-mode                      # Insert key
        bindkey '^[[3~' delete-char                         # Delete key
        bindkey '^[[C'  forward-char                        # Right key
        bindkey '^[[D'  backward-char                       # Left key
        bindkey '^[[5~' history-beginning-search-backward   # Page up key
        bindkey '^[[6~' history-beginning-search-forward    # Page down key
        # Navigate words with ctrl+arrow keys
        bindkey '^[Oc' forward-word
        bindkey '^[Od' backward-word
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
        # delete previous word with ctrl+backspace
        bindkey '^H' backward-kill-word
      '';
      zplug={
        enable = true;
        plugins=[{
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }];
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      };
    };
    gtk = {
      enable=true;
      gtk3.extraConfig = {
      Settings = "gtk-application-prefer-dark-theme=1";
      };
    gtk4.extraConfig = {
      Settings = "gtk-application-prefer-dark-theme=1";
    };
    iconTheme = {
      name = "Flat-Remix-Red-Dark";
      # package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Flat-Remix-GTK-Red-Darkest";
      # package = pkgs.palenight-theme;
    };
    # cursorTheme = {
    #   name = "Numix-Cursor";
    #   package = pkgs.numix-cursor-theme;
    # };
    };
    home.sessionVariables.GTK_THEME = "Flat-Remix-GTK-Red-Darkest";
  };
}