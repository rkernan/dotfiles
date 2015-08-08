RMDIR /S /Q "%USERPROFILE%\vimfiles"
XCOPY /E /I /H "vim" "%USERPROFILE%\vimfiles"
DEL "%userprofile%\.gitconfig"
COPY "gitconfig" "%USERPROFILE%\.gitconfig."
DEL "%USERPROFILE%\.gitignore"
COPY "gitignore" "%USERPROFILE%\.gitignore."
PAUSE
