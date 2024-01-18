# for WSL
if [[ `uname -r` =~ .*WSL.* ]]; then
  if [[ -z WINHOME ]]; then
    export WINHOME=/mnt/c/Users/rex
  fi

  cp "$WINHOME/Application Data/wsltty/config" "$WINHOME/Application Data/wsltty/config.bak"
  cp wsl/wsltty/config "$WINHOME/Application Data/wsltty/config"
  cp wsl/wsltty/themes/favorite "$WINHOME/Application Data/wsltty/themes/favorite"

  mkdir -p "$WINHOME/AppData/Roaming/alacritty"
  cp wsl/alacritty/alacritty.yml "$WINHOME/AppData/Roaming/alacritty/alacritty.yml"

  mkdir -p "$WINHOME/.config/wezterm"
  cp wsl/wezterm/wezterm.lua "$WINHOME/.config/wezterm/wezterm.lua"
else
  echo "Nothing to do"
fi
