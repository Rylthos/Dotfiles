SEARCH=$(wofi --show dmenu -p "Firefox Search" -L 1 -b)
SUCCESS=$(echo $?)

echo $SEARCH
echo $SUCCESS

if [[ $SUCCESS == 0 ]]; then
    firefox --search "$SEARCH"
fi
