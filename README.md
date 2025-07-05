# 🌐 My GNOME Arch Linux Rice

A clean and modern GNOME setup using GDM on Arch Linux.

## 🖼 Features

- Icon Theme: [Your Icon Theme]
- GTK Theme: [Your GTK Theme]
- Extensions:
  - Dash to Panel
  - Arc Menu
- Custom GNOME Layout
- Wallpaper: Included

## 🛠 Install Instructions

1. Clone this repo
2. Apply wallpaper from `wallpaper/`
3. Copy `themes/` and `icons/` to `~/.themes/` and `~/.icons/` (if custom)
4. Install GNOME extensions (listed above)
5. Restore layout:

```bash
dconf load / < gnome-config/dconf-settings.ini
