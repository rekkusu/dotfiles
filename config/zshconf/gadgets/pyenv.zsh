
add_path_if_exists $HOME/.pyenv/bin
if _installed pyenv; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
