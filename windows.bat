MKLINK /j "%USERPROFILE%\vimfiles" "vim"
DEL "%userprofile%\.gitconfig"
COPY "gitconfig" "%USERPROFILE%\.gitconfig."
DEL "%USERPROFILE%\.gitignore"
COPY "gitignore" "%USERPROFILE%\.gitignore."
PAUSE
