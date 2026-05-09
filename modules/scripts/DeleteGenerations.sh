#!/bin/sh

# echo $1
nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than $1
