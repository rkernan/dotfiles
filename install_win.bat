rmdir /s /q "%USERPROFILE%\AppData\Local\nvim"
mklink /j "%USERPROFILE%\AppData\Local\nvim" "nvim\.config\nvim"

del "%USERPROFILE%\.gitconfig"
copy "git\.config\git\config" "%USERPROFILE%\.gitconfig"

pause
