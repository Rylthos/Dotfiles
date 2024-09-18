{ config, pkgs, lib, inputs, ... }:
{
    environment = {
        variables = {
            CODING = "$HOME/coding";
        };
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;
}
