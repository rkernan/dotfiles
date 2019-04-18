if [ -f "${HOME}/.Xresources" ]; then
  xrdb -merge "${HOME}/.Xresources"
fi

exec awesome --no-argb

session=${1:-awesome}
case $session in
  awesome)
    exec awesome
    ;;
  *)
    exec $*
    ;;
esac
