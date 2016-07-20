MKLINK /j "%USERPROFILE%\vimfiles" "vim"
MKLINK /j "%LOCALAPPDATA%\nvim" "config\nvim"
DEL "%userprofile%\.gitconfig"
COPY "gitconfig" "%USERPROFILE%\.gitconfig."
DEL "%USERPROFILE%\.gitignore"
COPY "gitignore" "%USERPROFILE%\.gitignore."
PAUSE
