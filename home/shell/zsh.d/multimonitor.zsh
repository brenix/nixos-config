# Display single
ds() {
  xrandr --output HDMI-0 --off
}

# Display extend
de() {
  xrandr --output HDMI-A-0 --mode 2560x1440 --rate 144 --right-of DisplayPort-0
  bspc desktop 3 -m HDMI-A-0
  bspc desktop 4 -m HDMI-A-0
  bspc desktop Desktop -r
}
