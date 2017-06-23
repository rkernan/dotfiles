rmdir /s /q "%USERPROFILE%\vimfiles"
del "%USERPROFILE%\_vimrc"
mklink /j "%USERPROFILE%\vimfiles" "vim\.vim"
copy "vim\.vimrc" "%USERPROFILE%\_vimrc"

del "%USERPROFILE%\.gitconfig"
copy "git\.gitconfig" "%USERPROFILE%\.gitconfig"

pause
