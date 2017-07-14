rmdir /s /q "%USERPROFILE%\AppData\Local\nvim"
mklink /j "%USERPROFILE%\AppData\Local\nvim" "nvim\.config\nvim"

rmdir /s /q "%USERPROFILE%\vimfiles"
mklink /j "%USERPROFILE%\vimfiles" "vim\.vim"

del "%USERPROFILE%\.gitconfig"
copy "git\.gitconfig" "%USERPROFILE%\.gitconfig"

pause
