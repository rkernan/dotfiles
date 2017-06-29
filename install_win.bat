rmdir /s /q "%USERPROFILE%\vimfiles"
mklink /j "%USERPROFILE%\vimfiles" "vim\.vim"

del "%USERPROFILE%\.gitconfig"
copy "git\.gitconfig" "%USERPROFILE%\.gitconfig"

pause
