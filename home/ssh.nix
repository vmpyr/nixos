{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # Load keys into the agent on first use: passphrase asked once per login
    settings."*".AddKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;
}
