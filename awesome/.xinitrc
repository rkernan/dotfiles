if [ -f ~/.Xresources ]; then
	xrdb -merge ~/.Xresources
fi

exec awesome --no-argb
