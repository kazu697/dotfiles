# ----------------------------------------------------
# zcompile - Compile zsh files for faster loading
# ----------------------------------------------------
# Compile zsh file if not compiled or source is newer
function ensure_zcompiled {
  local src=$1
  local zwc="$src.zwc"
  if [[ ! -r "$zwc" || "$src" -nt "$zwc" ]]; then
    zcompile "$src"
  fi
}

# Override source to auto-compile
function source {
  ensure_zcompiled "$1"
  builtin source "$1"
}

# ----------------------------------------------------
# Keybind
# ----------------------------------------------------
source "$ZRCDIR/bindkey.zsh"

# ----------------------------------------------------
# Alias
# ----------------------------------------------------
source "$ZRCDIR/alias.zsh"

# ----------------------------------------------------
# Options
# ----------------------------------------------------
source "$ZRCDIR/option.zsh"
