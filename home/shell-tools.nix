{
  programs.eza = {
    enable = true;
    enableZshIntegration = false; # aliases are defined in zsh.nix
  };

  # Replaces `cd` with zoxide (`cd foo` jumps to best match, `cdi` is interactive)
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  # Silence zoxide's "possible configuration issue" doctor warning
  home.sessionVariables._ZO_DOCTOR = "0";
}
