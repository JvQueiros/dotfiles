#!/bin/bash

# installing the packages

packages = (
  stow,
  starship,
  ghostty,
  tmux,
  dysk,
  fuzzy,
  harpoon,
  nvim,
  yazi,
  )

for package in ${packages[@]}; do
  yay -S --noconfirm --needed ${package}
done

# Set the files
if [ $? -eq 0 ]; then
  echo "removing old configs"
  rm -rf ~/.config/tmux/tmux.conf ~/.config/nvim ~/.config/starship.toml ~/.local/share/nvim/ ~/.cache/nvim/ ~/.config/ghostty/config

  stow ghostty
  stow tmux
  stow nvim
  stow starship
else
  echo "Failed to clone the repository."
  exit 1
fi
