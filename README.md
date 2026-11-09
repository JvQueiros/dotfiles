# Dotfiles

My desktop and terminal configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level folder is a package whose contents mirror the home directory, so
`starship/.config/starship.toml` is linked to `~/.config/starship.toml`.

## Packages

| Package    | Links to                  | Omarchy | Other systems |
| ---------- | ------------------------- | :-----: | :-----------: |
| `bash`     | `~/.bashrc`               |   yes   |      no       |
| `git`      | `~/.gitconfig`            |   yes   |      yes      |
| `hypr`     | `~/.config/hypr/`         |   yes   |      no       |
| `nvim`     | `~/.config/nvim/`         |   yes   |      yes      |
| `starship` | `~/.config/starship.toml` |   yes   |      yes      |
| `waybar`   | `~/.config/waybar/`       |   yes   |      yes      |

`bash` and `hypr` depend on files that only Omarchy provides, so the install
script skips them everywhere else.

## Install

```bash
git clone git@github.com:JvQueiros/dotfiles.git ~/gitHub/dotfiles
cd ~/gitHub/dotfiles
./install.sh
```

The script installs the programs with `yay` on Arch or `apt-get` on Ubuntu and
Debian, then links every package. It can be run again safely. To relink without
installing anything:

```bash
./install.sh --link-only
```

### What happens to existing files

Nothing is deleted. Any file that would conflict is moved to
`~/.dotfiles-backup/<date>/` before linking, which is where to look if something
you wanted was replaced.

Neovim is the exception to file-by-file linking: on the first run, the existing
`~/.config/nvim`, `~/.local/share/nvim`, and `~/.cache/nvim` are all moved to
the backup, because a LazyVim setup mixed with this config doesn't work.

## Daily use

The files in `~` are symlinks into this repository, so editing either one
changes both. Commit from here to save a change:

```bash
cd ~/gitHub/dotfiles
git add -A
git commit -m "Describe the change"
git push
```

Manage a single package from the repository root. `.stowrc` already sets the
target to `~`:

```bash
stow waybar       # link
stow -R waybar    # relink, after adding or removing files
stow -D waybar    # unlink
```

### Adding a new config

Create a package that mirrors the path from `~`, then add its name to
`stow_packages` in `install.sh`:

```bash
mkdir -p ghostty/.config/ghostty
mv ~/.config/ghostty/config ghostty/.config/ghostty/
stow ghostty
```

### After an Omarchy update

An update can replace a symlink with a regular file. To bring it back under the
repository, keeping the file it finds in the backup folder:

```bash
./install.sh --link-only
```

## Machine-specific and unmanaged files

- `hypr/.config/hypr/monitors.lua` describes this PC's screens. Edit it on a
  machine with different displays.
- `~/.config/hypr/shaders` belongs to Aether and is deliberately left out of
  both Stow and Git.
- Ghostty and tmux stay on Omarchy's default configs, so they aren't packages.
- `waybar/.config/waybar/theme.css` is generated and ignored by Git.

## Waybar

Omarchy has its own bar, so Waybar doesn't start on its own:

```bash
~/.config/waybar/scripts/launch.sh    # start or restart
pkill -x waybar                       # stop
```

Always start it with `launch.sh`, because that creates the `theme.css` the
stylesheet needs. While running, the bar follows the current Omarchy theme.

| Element    | Action       | Result                         |
| ---------- | ------------ | ------------------------------ |
| Clock      | Left click   | Open Google Calendar           |
| Clock      | Right click  | Show the calendar              |
| Clock      | Middle click | Change the timezone            |
| Stay awake | Left click   | Keep the system from idling    |
| Brightness | Scroll       | Change brightness              |
| Network    | Left click   | Network settings               |
| Bluetooth  | Left click   | Bluetooth settings             |
| Volume     | Left click   | Audio settings                 |
| Volume     | Right click  | Mute                           |
| CPU        | Left click   | Open `btop`                    |
| CPU        | Right click  | Open a terminal                |
| Media      | Left click   | Play or pause                  |
| Media      | Middle click | Previous track                 |
| Media      | Right click  | Next track                     |

Hover the world clocks to see every city. The list is in the `cities` array in
`waybar/.config/waybar/scripts/bar`.

### Outside Omarchy

`scripts/bar` uses Omarchy's commands when they exist and generic tools
otherwise, so the config is the same on every system. A few things to know:

- The session must be Hyprland. Stock GNOME can't display Waybar, and the
  workspaces module only works on Hyprland.
- Install JetBrainsMono Nerd Font for the icons.
- The right-click calendar is a plain notification.

To try the fallbacks on an Omarchy machine:

```bash
BAR_PLATFORM=generic ~/.config/waybar/scripts/bar weather
```
