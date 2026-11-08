{ lib, pkgs, ... }:

{
  # command-not-found replacement (from nix-index-database) + comma: `, cowsay hi`
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

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
      expireDuplicatesFirst = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = ""; # prompt comes from powerlevel10k below

      plugins = [
        "git"
        "sudo"
        "docker"
        "docker-compose"
        "systemd"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      ls = "eza --icons=always --group";
      ll = "eza -la --icons=always --group --header --git";
      la = "eza -l --icons=always --group --header --git";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#aragorn";
      nru = "nix flake update --flake ~/nixos-config && sudo nixos-rebuild switch --flake ~/nixos-config#aragorn"; # update all inputs + rebuild
    };

    initContent = lib.mkMerge [
      # p10k instant prompt: must stay at the very top of .zshrc
      (lib.mkBefore ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')

      ''
        # Prompt config (edit home/p10k.zsh in the repo; `p10k configure` writes ~/.p10k.zsh, copy it back)
        source ${./p10k.zsh}

        setopt hist_verify
        bindkey '^[[A' history-search-backward
        bindkey '^[[B' history-search-forward

        export GPG_TTY=$(tty)

        # OpenRouter configuration
        if [[ -f "$HOME/.config/secrets/openrouter.env" ]]; then
          source "$HOME/.config/secrets/openrouter.env"
        fi

        export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
        export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_CLAUDE_API_KEY"
        export ANTHROPIC_API_KEY=""
        export CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1
      ''
    ];
  };
}
