{ config, pkgs, ... }:

let 
  inputs = import ~/configs/nix/inputs.nix;
in {
  imports = 
    [
      ./nvim.nix
      ./tmux.nix
      ./zsh.nix
      ./hyprland.nix
    ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = inputs.user;
  home.homeDirectory = inputs.homeDir;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages
  home.packages = with pkgs; [
    xfce.xfce4-terminal
    alacritty
    neofetch
    figlet
    xclip
    dmenu
    rofi
    calcurse
    font-awesome
    brightnessctl
    dua
    # fractal # matrix
    # signal-desktop
    firefox

    # Nix Utils
    nix-prefetch-github

    # NixGL to run nix graphical applications on non-NixOS systems
    nixgl.auto.nixGLDefault

    # Sway / Hyprland
    swaylock # lockscreen
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    wofi # app launcher
    wl-clipboard # clipboard management (cli)
    swaybg # wallpaper launcher
    mako # notification daemon

    # Rust
    gcc
    rustup

    # Rust Apps
    lsd
    bat
    ripgrep

    # LSPs
    python310Packages.python-lsp-server
    nodePackages.typescript-language-server
    kotlin-language-server
    nil
  ];

  programs.git = {
    enable = true;
    userName = "Sean Flinn";
    userEmail = "sflinn54@gmail.com";
  };

  # manage fonts via home manager
  fonts.fontconfig.enable = true;

  # dotfiles. See github: https://github.com/spf5000/configs
  xdg.configFile."alacritty".source = ~/configs/.config/alacritty;
  xdg.configFile."sway".source = ~/configs/.config/sway;
  xdg.configFile."swaylock".source = ~/configs/.config/swaylock;
  xdg.configFile."waybar".source = ~/configs/.config/waybar;
  xdg.configFile."xfce4".source = ~/configs/.config/xfce4;
  xdg.configFile."hypr".source = ~/configs/.config/hypr;
  xdg.configFile."nix".source = ~/configs/.config/nix;
 }
