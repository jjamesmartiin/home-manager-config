{ pkgs, lib, ... }:
{
  packages = with pkgs; [
    mdr # markdown renderer
    git # git ofc
    lazygit # ez git manager
    ccrypt # encryption for journal
    pandoc # text converter (mediawiki to markdown) 
    hstr # history search for bash
  ]
}
