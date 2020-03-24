# dotfiles

## To-do
- Move all GUI configuration to common stow directory.
- Awesome WM -> Better error handling

## Arch Setup
- Base install: `base base-devel linux linux-firmware`
- `NetworkManager.service`
- `systemd-timesyncd.service`
- `systemd-resolvconf.service`
- `aur/reflector-timer`
- `tlp` + `tlp-rdw`

### GUI applications
- `bluez`
- `dropbox`
- `kitty`
- `lightdm` + `lightdm-gtk-greeter` + `light-locker`
- `nm-applet`
- `rofi` + `rofi-pass`
- `udiskie`

### Modified files
- `/etc/lightdm/lightdm.conf`
- `/etc/lightdm/lightdm-gtk-greeter.conf`
- `/etc/NetworkManager/dispatcher.d/timezone`
- `/etc/pacman.d/hooks/systemd-boot.hook`
- `/etc/systemd/sleep.conf`
- `/etc/systemd/logind.conf`
- `/etc/tlp.conf`
- `/etc/X11/xorg.conf.d/20-video.conf`
- `/etc/X11/xorg.conf.d/30-touchpad.conf`
- `/etc/udev/rules.d/99-lowbatt.rules`

### Fonts
- `noto-fonts`
- `noto-fonts-cjk`
- `noto-fonts-emoji`
- `noto-fonts-extra`
- `ttf-fira-code`
- `ttf-fira-mono`
- `ttf-fira-sans`

Services:
- `xorg-font-config`
- `xorg-fonts-alias`
- `xorg-fonts-encoding`
- `xorg-mkfontscale`
