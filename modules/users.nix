{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false; # Home Manager runs compinit; avoid doing it twice
  };
  environment.pathsToLink = [ "/share/zsh" ]; # completions for system packages

  users.users.vmpyr = {
    isNormalUser = true;
    description = "vmpyr";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICB+G1Rc3/coKy+IQU3ypgnCrzAmb6dTj8+fBwG1JGCp hi@vmpyr.me"
    ];
  };
}
