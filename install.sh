#!/bin/bash
# Instala os programas e liga as configurações em $HOME com o GNU Stow.
# Uso: ./install.sh [--link-only]   (--link-only pula a instalação de pacotes)

# Para no primeiro erro.
set -euo pipefail

# O stow resolve os pacotes a partir do diretório atual, então o script precisa
# funcionar de qualquer lugar.
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

arch_packages=(stow starship ghostty tmux dysk fzf neovim yazi waybar playerctl)
apt_packages=(stow tmux fzf neovim waybar playerctl pamixer brightnessctl ddcutil jq curl)

# hypr e bash dependem de arquivos do Omarchy; fora dele só o resto faz sentido.
if command -v omarchy >/dev/null; then
  stow_packages=(bash git hypr nvim starship waybar)
else
  stow_packages=(git nvim starship waybar)
fi

backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Move em vez de apagar, para nada se perder se o repositório estiver desatualizado.
backup() {
  local relative="${1#"$HOME"/}"
  mkdir -p "$backup_dir/$(dirname "$relative")"
  mv "$1" "$backup_dir/$relative"
}

if [[ "${1:-}" != "--link-only" ]]; then
  echo "Iniciando a instalação dos pacotes..."
  if command -v yay >/dev/null; then
    yay -S --noconfirm --needed "${arch_packages[@]}"
  elif command -v apt-get >/dev/null; then
    sudo apt-get install -y "${apt_packages[@]}"
  else
    echo "Gerenciador de pacotes não suportado; instale manualmente e use --link-only." >&2
    exit 1
  fi
fi

# Uma configuração do LazyVim misturada com a deste repositório não funciona, então
# o nvim é substituído por inteiro, mas só na primeira vez: depois disso já é um link.
if [[ -e "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
  echo "Guardando a configuração antiga do nvim..."
  for path in "$HOME/.config/nvim" "$HOME/.local/share/nvim" "$HOME/.cache/nvim"; do
    if [[ -e "$path" ]]; then backup "$path"; fi
  done
fi

echo "Aplicando o GNU Stow..."
for package in "${stow_packages[@]}"; do
  # Pergunta ao próprio stow o que conflita, assim os arquivos ignorados são respeitados.
  while IFS= read -r target; do
    backup "$HOME/$target"
  done < <(stow -n -t "$HOME" "$package" 2>&1 | sed -n 's/.* over existing target \(.*\) since .*/\1/p')

  stow -R -t "$HOME" "$package"
done

if [[ -d "$backup_dir" ]]; then
  echo "Arquivos substituídos foram guardados em $backup_dir"
fi
echo "Instalação concluída com sucesso!"
