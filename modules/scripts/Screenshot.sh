date=$(date +'%Y%m%d_%Hh%Mm%Ss_grim.png')
file=$(xdg-user-dir PICTURES)/Screenshots/$date
grim -g "$(slurp -d -w 1)" $file && wl-copy < $file
