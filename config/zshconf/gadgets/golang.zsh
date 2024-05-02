
add_path_if_exists /usr/local/go/bin
if _installed go; then
  export GOPATH=$HOME/go
  add_path_if_exists $GOPATH/bin
fi
