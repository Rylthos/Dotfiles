{ self, ... }: {
  flake.modules.nixos.base-ssh = { ... }: {
    programs.ssh.startAgent = true;

    services.openssh = {
        enable = true;
        openFirewall = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
            AllowUsers = null;
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "prohibit-password";
        };
    };
  };
}
