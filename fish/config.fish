if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
end

# opam configuration
source /home/aaron/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
