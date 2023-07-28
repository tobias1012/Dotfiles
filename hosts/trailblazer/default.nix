{ config, lib, pkgs, modulesPath, inputs, ... }:
{
    imports = [
        ../common.nix
        ./hardware.nix
        inputs.home-manager.nixosModules.home-manager

    ];


    networking.hostName = "trailblazer"; # Define your hostname.


    # Configure keymap in X11
  services.xserver = {
    layout = "dk";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";



  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tobias = {
    isNormalUser = true;
    description = "Tobias";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "Hack" "DroidSansMono" ]; })
];
  fonts.fontconfig.defaultFonts.monospace = [ "Hack" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tlp # laptop power management
    firefox-wayland
    zsh
    zsh-z
    oh-my-zsh
    spotify
    alacritty # gpu accelerated terminal
    #kitty
    #waybar
    wayland
    glib # gsettings
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    swaylock
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    mako # notification system developed by swaywm maintainer
    pkg-config
    dbus
    unzip
    
    #Apps
    blender
    krita
    vlc

    #Sound suff
    mpd
    pavucontrol
    
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #programs.hyprland.enable = true;

  # List services that you want to enable:

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  #servies.dbus.enable = true;
  #xdg.portal = {
  #  enable = true;
  #  wlr.enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #};

  #enable gio module
  environment.sessionVariables = rec { 
    GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/";
  };
    home-manager.extraSpecialArgs = { inherit inputs; };
    home-manager.users.tobias = import ../../home/tobias/${config.networking.hostName}.nix;
}
