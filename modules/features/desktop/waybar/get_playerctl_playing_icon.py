#!/usr/bin/env python3

import subprocess

icons = { "play": "", "pause": "", "none": "󰋔"}

execution = subprocess.Popen("playerctl status", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
output = execution.stdout.read()
err = execution.stderr.read()
if output == b"Playing\n":
    print(icons["pause"])
elif output == b"Paused\n":
    print(icons["play"])
elif err == b"No players found\n":
    print(icons["none"])
