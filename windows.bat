RMDIR /s "%USERPROFILE%\vimfiles"
MKLINK /j "%USERPROFILE%\vimfiles" ".vim"
DEL "%userprofile%\.gitconfig"
COPY ".gitconfig" "%USERPROFILE%\.gitconfig."
PAUSE
