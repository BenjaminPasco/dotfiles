# homebrew
We need to install homebrew (for ghostty because nix package is broken:
```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

first command to build the nix.flake file with "default" profile:
nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.default.system
this command should build and create a .result directory symlinked to the /nix/store directory

then run this to build the config:
```bash
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#default
```

and then after a first successfull build use:
```bash
  sudo darwin-rebuild switch --flake .#default
```

# rmpc:
description: terminal audio player usibg mpd daemon, can read music from youtube, open using "rmpc"
other commands/keymaps:
q - quit
In case of issue, restart mpd and then rmpc:
```
  pgrep mpd
  kill {id}
  mpd ~/.config/mpd/mpd.conf
  rmpc
```
Adding music from youtube:
press ":", then type
```
  addyt {youtube url}
```

# Berkeley Mono:
description: derivation used to take patched Berkeley mono font files and add them to our fonts
Copy your pre-patched Berkeley Mono Nerd Font files:
```bash
  cp /path/to/your/patched/berkeley-mono/*.ttf fonts/berkeley-mono/patched/
```

Then do a rebuild:
```bash
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#default
  or
  sudo darwin-rebuild switch --flake .#default
```

# Keymaps:
## Aerospace:
Here we use modes to do stuff
by default we are in main mode
- go to move mode: shift + option + m
- then 1, 2, 3, ... to move the current node (program window) to workspace 1, 2, 3, ...
- go to go mode: shift + option + g
- then 1, 2, 3, ... to move to workspace 1, 2, 3, ...
- move node accross monitors (cycling if 3 or more): shift + option + tab
- cycling between monitors: option + tab

## Kitty:
- new tab: cmd + t
- go to left tab: cmd + shift + h
- go to right tab: cmd + shift + l
- new pane to right: cmd + %
- new pane to bottom: cmd + "
- move across panes: cmd + h/j/k/l
- resize pane: cmd + r

## Raycast:
- open raycast: option + space

## Yazi:
- open file explorer: yazi
- moving around: h/j/k/l
- opening files: o/enter
