# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./shares.nix
      ./sway.nix
      (import "${home-manager}/nixos")
      ./hm-lukaszpe.nix
    ];

  # Bootloader.
  boot={
    #Set grub
    loader.grub.enable = true;
    loader.grub.device = "/dev/vda";
    loader.grub.useOSProber = false;
    loader.timeout=1;
    #Set Plymouth
    #plymouth.enable=true;
    # plymouth.theme="lone";
    kernelParams = [
      "video=card0-DVI-D-1:1980x1080@60"
      "video=card0-HDMI-A-1:1980x1080@60"
      "video=card0-DP-1:1980x1080@60"
    ];
  };
  hardware={
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      # extraPackages = with pkgs; [
      #   rocm-opencl-icd
      #   rocm-opencl-runtime
      #   amdvlk
      # ];
    };
    #AMD GPU KERNEL DRIVERS
    # initrd.kernelModules = [ "amdgpu" ];
    #NVIDIA KERNEL DRIVERS
  nvidia = {
    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;
    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;
    # Enable the nvidia settings menu
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # #Bluetooth
  # bluetooth={
  #   enable = true;
  #   settings = {
  #     General = {
  #     Enable = "Source,Sink,Media,Socket";
  #     };
  #   };
  # };
  # pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  # };
  # RedistHardware
  enableRedistributableFirmware=true;
  };
  networking={
    hostName = "EGNix"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";
  # Configure console font and keymap
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "pl2";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users={
    groups={
      lukaszpe.gid=1000;
    };
    users.lukaszpe = {
      isNormalUser = true;
      description = "Łukasz Pękalski";
      group ="lukaszpe";
      extraGroups = [ "wheel" "networkmanager" "kvm" "input" "disk" "libvirtd"];
      packages = with pkgs; [];
    };
  };
  #Set shell for ALL users
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment={
    shellAliases={
      clne="clear && neofetch";
      swaygo="sway --unsupported-gpu";
      gcrs ="cd /home/lukaszpe/Programowanie/NixOS_CFG && git pull && ./copy.sh && sudo nixos-rebuild switch";
      #gcrs="sudo scp lukaszpe@EGM:/home/lukaszpe/Dokumenty/NIX/\\*.nix /etc/nixos/ && sudo nixos-rebuild switch";
    };
    systemPackages = with pkgs; [
      #System tools
        pciutils
        usbutils
        neofetch
        wget
        nfs-utils
        samba
        ntfs3g
        tree
        tldr
        home-manager
        pulseaudioFull
        git
        udisks
        cifs-utils
      #SWAY APPS
        alacritty
        waybar
        libappindicator-gtk3
        libappindicator
        rofi-wayland
        rofi-power-menu
        flat-remix-gtk # gtk theme
        flat-remix-icon-theme  # default gnome cursors
        grim # screenshot functionality
        slurp # screenshot functionality
        fuzzel
        polkit_gnome
        gnome.geary
        gnome.gnome-calendar
        gnome.gnome-calculator
        gnome.cheese
        gnome-photos
        gnome.gnome-clocks
        gnome.gnome-weather
        gnome.nautilus
        gnome.nautilus-python
        gnome.sushi
        gvfs
        gnome.gvfs
        gnome.gedit
        qgnomeplatform-qt6
        qgnomeplatform
        gnome-online-accounts
        gnome.file-roller
        gnome.gnome-characters
        gnome.gnome-disk-utility
        gnome.gnome-system-monitor
        blueman
        playerctl
        autotiling
        numlockx
        pavucontrol
        networkmanager
        networkmanagerapplet
        udiskie
        wayland-utils
      #General Tools
        doublecmd
        htop
        p7zip
        plymouth
        adi1090x-plymouth-themes
        zsh
        meslo-lgs-nf
        zsh-powerlevel10k
        vlc
        firefox
        looking-glass-client
        steamcontroller
        libreoffice-fresh
        gthumb
        gimp-with-plugins
        discord
        brasero
        skypeforlinux
        obs-studio
        obsidian
        obs-studio-plugins.obs-3d-effect
        obs-studio-plugins.wlrobs
        obs-studio-plugins.obs-vaapi
        obs-studio-plugins.obs-vkcapture
        obs-studio-plugins.obs-gstreamer
        obs-studio-plugins.input-overlay
        obs-studio-plugins.looking-glass-obs
        signal-desktop
        telegram-desktop
        prusa-slicer
        freecad
        steam
        #zoom-us
        vscode
        teams
        evince
    ];
  };

fonts.fonts = with pkgs; [
  # fira-code
  # fira
  # cooper-hewitt
  # ibm-plex
  # jetbrains-mono
  # iosevka
  # # bitmap
  # spleen
  # fira-code-symbols
  # powerline-fonts
  # nerdfonts
  meslo-lgs-nf
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs={
    # Enable zsh shell
    zsh={
      enable = true;
      histSize=1000000;
    };
    #other
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    gnome-disks.enable=true;
    #Geary (mail client)
    geary.enable=true;
  };

  # List services that you want to enable:
  services={
    gvfs.enable=true;
    # Configure keymap in X11
    xserver = {
      layout = "pl,de";
      xkbModel = "pc105";
      xkbVariant = ",us";
      xkbOptions = "grp:menu_toggle";
      videoDrivers = ["nvidia"];
      # videoDrivers = [ "amdgpu" ];
    };
    # Enable automatic login for the user.
    getty.autologinUser = "lukaszpe";
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    #Sway
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    #Udisks
    udisks2.enable=true;
    #Blueman
    blueman.enable=true;
    #Samba
    samba={
      enable=true;
    };
    samba-wsdd={
      enable=true;
      workgroup="Workgroup";
    };
  };

  #Sway
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  security.polkit.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system={
    stateVersion = "23.05"; # Did you read the comment?
    copySystemConfiguration = true;
  };
 
  #SystemD
  systemd.user={
    timers."numlockx_boot" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
      OnStartupSec = "1us";
      AccuracySec = "1us";
      Unit = "numlockx.service";
      };
    };
    timers."numlockx_sleep" = {
      wantedBy = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
      ];
      after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
      ];
      timerConfig = {
      AccuracySec = "1us";
      Unit = "numlockx.service";
      };
    };
    services."numlockx" = {
      script = ''
      ${pkgs.numlockx}/bin/numlockx on
      '';
      serviceConfig = {
      Type = "simple"; # "simple" für Prozesse, die weiterlaufen sollen
      };
    };
  };
}
