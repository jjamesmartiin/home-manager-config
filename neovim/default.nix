{ config, pkgs, ...}:
let
  link = config.lib.file.mkOutOfStoreSymlink;

  # vim packages not in nixpkgs, but from github
  ccryptor-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "ccryptor.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "kurotych";
      repo = "ccryptor.nvim";
      rev = "4b2cd7fbf54eb8385d023b7411be4a46ab0eded8";
      hash = "sha256-CUjM8cr+SbgSd+NFbHysxogbq0QPJ/pXdSGo4p5AuHo=";
    };
  };
  telescope-ag = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-ag";
    src = pkgs.fetchFromGitHub {
      owner = "kelly-lin";
      repo = "telescope-ag";
      rev = "7d25064da3c7689461bcfa89ad1f08548415193d";
      hash = "sha256-xOgiiTElHLgx7Gwp6aR0Ipfanq6ZTTgiQv9Zs3LTb1g=";
    };
  };

in
{
  programs.ripgrep.enable = true;
  programs.fd.enable = true; # find replacement; depends on ripgrep and for telescope
  programs.fzf.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox # theme
      vim-nix # nix language
      vim-lsp # lsp
      telescope-nvim # fuzzy finder
      telescope-fzf-native-nvim
      # copilot-vim # copilot, no more copilot, bad ai go google 240809
      oil-nvim # OIL file manager, view link for help https://github.com/stevearc/oil.nvim?tab=readme-ov-file
      lazygit-nvim # git support 
      markdown-preview-nvim # markdown preview ... seems to be ok but can't use unless running X11 server
      # tmux navigator, depends on tmux plugin in config
      vim-tmux-navigator
      vim-commentary # comment out lines
      vim-windowswap ## <leader>ww to swap windows  # update 250107 doesn't work?
      git-blame-nvim # git blame
      limelight-vim # used for highlighting the current line

      # leap-nvim # fast, two char nav
      flash-nvim # fast nav using s

      # adding a gitlinker that lets me grab URLS
      gitlinker-nvim

      # fzf-lua

      # DIY Plugins
      # telescope-ag
      ccryptor-nvim

      # conflict marker vim 
      conflict-marker-vim

      # in vim terminal, configured for pop up
      toggleterm-nvim

      # 250110 doesn't seem to be working
      # I got rid of vim-pandoc in favor of a manual thing with <Leader>M
      # autocomplete
      # blink-cmp # I don't think this is working right now... 250329
    ];
  };

  home.file.".config/nvim/init.lua" = { 
    enable = true;
    source = link ./nvim.lua;
  };
}

# make an alias for the find and replace but in vim
## `find . -type f -name "*.txt" -exec sed -i 's/old_word/new_word/g' {} +`
# 

