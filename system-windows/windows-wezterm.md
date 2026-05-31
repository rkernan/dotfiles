Export %USERPROFILE% so it's available in WSL:
```
setx WSLENV USERPROFILE/up
```

Set WEZTERM_DEFAULT_DOMAIN to automatically enter WSL:
```
setx WEZTERM_DEFAULT_DOMAIN 'WSL:archlinux'
```
