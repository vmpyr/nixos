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
}
