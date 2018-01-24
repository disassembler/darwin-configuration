{ config, lib, pkgs, ... }:
let
  secrets = import ./secrets.nix;
  custom_modules = (import ./modules/modules-list.nix);

in {
  imports = 
  [
  ] ++ custom_modules;

  profiles.tmux.enable = true;
  profiles.zsh.enable = true;
  profiles.kwm.enable = true;
  profiles.osx.enable = true;


  environment.systemPackages =
    [ pkgs.ctags
      pkgs.curl
      pkgs.pythonPackages.upass
      pkgs.dnsmasq
      pkgs.gnupg
      pkgs.pass
      pkgs.fasd
      pkgs.brotli
      pkgs.fzf
      pkgs.gettext
      pkgs.git
      pkgs.openvpn
      #pkgs.openconnect
      pkgs.htop
      pkgs.jq
      pkgs.mosh
      pkgs.shellcheck
      pkgs.silver-searcher
      pkgs.nix-repl
      config.nix.package
    ];

  launchd.user.agents.fetch-nixpkgs = {
    command = "${pkgs.git}/bin/git -C ~/.nix-defexpr/nixpkgs fetch origin master";
    environment.GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    serviceConfig.KeepAlive = false;
    serviceConfig.ProcessType = "Background";
    serviceConfig.StartInterval = 360;
  };

  services.nix-daemon.enable = true;

  nix.extraOptions = ''
    gc-keep-derivations = true
    gc-keep-outputs = true
  '';

  nix.binaryCachePublicKeys = [ "cache.daiderd.com-1:R8KOWZ8lDaLojqD+v9dzXAqGn29gEzPTTbr/GIpCTrI=" ];
  nix.trustedBinaryCaches = [ https://d3i7ezr9vxxsfy.cloudfront.net ];
  nix.trustedUsers = [ "@admin" ];
  nix.useSandbox = true;
  nix.package = pkgs.nixUnstable;
  nix.nixPath =
    [ # Use local nixpkgs checkout instead of channels.
      "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
      "darwin=$HOME/.nix-defexpr/darwin"
      "nixpkgs=$HOME/.nix-defexpr/nixpkgs"
      "$HOME/.nix-defexpr/channels"
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
  };
  nix.maxJobs = 4;

  programs.nix-index.enable = true;

  environment.variables.FZF_DEFAULT_COMMAND = "ag -l -f -g ''";
  environment.variables.SHELLCHECK_OPTS = "-e SC1008";

  environment.shellAliases.g = "git log --pretty=color -32";
  environment.shellAliases.gb = "git branch";
  environment.shellAliases.gc = "git checkout";
  environment.shellAliases.gcb = "git checkout -B";
  environment.shellAliases.gd = "git diff --minimal --patch";
  environment.shellAliases.gf = "git fetch";
  environment.shellAliases.gl = "git log --pretty=color --graph";
  environment.shellAliases.glog = "git log --pretty=nocolor";
  environment.shellAliases.grh = "git reset --hard";
  environment.shellAliases.l = "ls -lh";
  environment.shellAliases.ls = "ls -G";
  environment.shellAliases.nb = "nix-build";
  environment.shellAliases.ni = "nix-instantiate";
  environment.shellAliases.ns = "nix-shell --run zsh";


  # TODO: add module for per-user config, etc, ...
  system.activationScripts.extraUserActivation.text = "ln -sfn /etc/per-user/sam/gitconfig ~/.gitconfig";

  environment.etc."per-user/sam/gitconfig".text = import ./git-config.nix;

  services.openvpn = secrets.openvpn_config;

}
