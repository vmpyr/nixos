{ pkgs, ... }:

{
  home.username = "vmpyr";
  home.homeDirectory = "/home/vmpyr";
  home.stateVersion = "26.05";   # same as system.stateVersion; never change it

  home.packages = with pkgs; [
    ripgrep
    fd
    btop

    unstable.claude-code
    # unstable.<pkg>
  ];

  programs.vscodium = {
    enable = true;
    package = pkgs.unstable.vscodium;

    profiles.default.extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      append = true;
      ignoreAllDups = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";

      plugins = [
        "git"
        "sudo"
        "docker"
        "docker-compose"
        "systemd"
        "command-not-found"
      ];
    };

    initContent = ''
      # OpenRouter configuration
      if [[ -f "$HOME/.config/secrets/openrouter.env" ]]; then
        source "$HOME/.config/secrets/openrouter.env"
      fi

      export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
      export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_CLAUDE_API_KEY"
      export ANTHROPIC_API_KEY=""
      export CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1
    '';
  };
}
