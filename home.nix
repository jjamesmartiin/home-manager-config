{ config, pkgs, ... }: 
let 
  # allow editing of files outside of the nix store
  link = config.lib.file.mkOutOfStoreSymlink;

  # get username (helpful for templating)
  username = builtins.getEnv "USER";
in
{
  # import my custom configuations
  imports = [
    ./neovim
    ./tmux
    ./bash
    ./gsnap
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    packages = (import ./installed-pkgs).packages;
    # packages = with pkgs; [
    #     # Install packages here, search at https://search.nixos.org/packages
    #     #     Add packages here, search at https://search.nixos.org/packages
    #     mdr # markdown renderer
    #     git # git ofc
    #     lazygit # ez git manager
    #     ccrypt # encryption for journal
    #     pandoc # text converter (mediawiki to markdown) 
    #     hstr # history search for bash
    # ];
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;  # required for home-manager to manage itself
  programs.home-manager.gitui.enable = true; # dep or lazygit
  programs.home-manager.zoxide = { # ez dir changing in terminal
    enable = true;
    enableBashIntegration = true;
  };

}

