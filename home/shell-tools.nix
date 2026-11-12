{
  programs.eza = {
    enable = true;
    enableZshIntegration = false; # aliases are defined in zsh.nix
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.bat.enable = true;
  programs.fzf.enable = true;

  # Silence zoxide's "possible configuration issue" doctor warning
  home.sessionVariables._ZO_DOCTOR = "0";
}
