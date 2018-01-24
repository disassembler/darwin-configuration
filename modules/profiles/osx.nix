{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.osx;
in {
  options.profiles.osx = {
    enable = mkEnableOption "osx configuration";
  };

  config = mkIf (cfg.enable)  {
    system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
    system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
    system.defaults.NSGlobalDomain.InitialKeyRepeat = 20;
    system.defaults.NSGlobalDomain.KeyRepeat = 1;
    system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

    system.defaults.dock.autohide = true;
    system.defaults.dock.orientation = "left";
    system.defaults.dock.showhidden = true;
    system.defaults.dock.mru-spaces = false;

    system.defaults.finder.AppleShowAllExtensions = true;
    system.defaults.finder.QuitMenuItem = true;
    system.defaults.finder.FXEnableExtensionChangeWarning = false;

    system.defaults.trackpad.Clicking = true;
    system.defaults.trackpad.TrackpadThreeFingerDrag = true;

    
  };
}
