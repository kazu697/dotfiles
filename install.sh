#!/usr/bin/env sh

set -e

export DOTFILES_DIR="$(pwd)"

ln -fns "${DOTFILES_DIR}/ghostty" "${HOME}/.config"
ln -fns "${DOTFILES_DIR}/config/.claude" "${HOME}"
ln -fns "${DOTFILES_DIR}/nvim" "${HOME}/.config"
ln -fns "${DOTFILES_DIR}/mise" "${HOME}/.config"

# install mise
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.zshrc
