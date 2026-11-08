{ pkgs, ... }:

{
  programs.brave = {
    enable = true;
    package = pkgs.unstable.brave;

    commandLineArgs = [ "--ui-toolkit=gtk" ];
  };
}
