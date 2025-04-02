# tmx
{ config, pkgs, ...}:
let
  link = config.lib.file.mkOutOfStoreSymlink;

  tmux-open = pkgs.tmuxPlugins.mkTmuxPlugin { 
    pluginName = "tmux-open";
    src = pkgs.fetchurl {
      url = "https://github.com/tmux-plugins/tmux-open/archive/763d0a852e6703ce0f5090a508330012a7e6788e.tar.gz";
      hash = "";
    };
  };
in
{
  home.packages = [
    pkgs.tmux
  ];

  programs.tmux = {
    # enable = true
    plugins = with pkgs.tmuxPlugins; [
      # tmux-open # for opening programs in the $EDITOR using tmux, probably not needed tho 
      # copycat # this is for searching on words in tmux, I don't use it like this yet
    ];
  };

  home.file.".config/tmux/tmux.conf" = { 
    enable = true;
    source = link ./tmux.conf;
  };

}

