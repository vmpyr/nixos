{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Ujjwal Sarswat";
        email = "hi@vmpyr.me";
      };
      init.defaultBranch = "master";
    };

    # Sign all commits and tags with the aragorn GPG key
    signing = {
      format = "openpgp";
      key = "580621A7EB449A069FD9FF50C0B7B11657FA64BA";
      signByDefault = true;
    };
  };

  # GitHub CLI; uses SSH for git operations
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
