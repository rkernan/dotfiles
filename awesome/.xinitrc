if [ -f "${HOME}/.Xresources" ]; then
  xrdb -merge "${HOME}/.Xresources"
fi

session=${1:-awesome}
case $session in
  awesome)
    exec awesome --no-argb
    ;;
  *)
    exec $*
    ;;
esac
