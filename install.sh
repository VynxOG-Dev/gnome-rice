#!/bin/bash

echo "🔧 Starting GNOME rice installation..."

# -----------------------------------------
# 0. Check dependencies
# -----------------------------------------
echo "📦 Checking dependencies..."

DEPENDENCIES=(dconf curl gnome-extensions gsettings unzip)

for pkg in "${DEPENDENCIES[@]}"; do
    if ! command -v $pkg &> /dev/null; then
        echo "⚠️ $pkg not found. Please install it before running this script."
        exit 1
    fi
done

# -----------------------------------------
# 1. Set wallpaper
# -----------------------------------------
echo "🖼 Setting wallpaper..."
WALLPAPER_PATH="$HOME/Pictures/wallpaper.png"
mkdir -p "$HOME/Pictures"
cp wallpaper/* "$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"

# -----------------------------------------
# 2. Install icons and themes
# -----------------------------------------
echo "🎨 Installing icons and themes..."
mkdir -p ~/.icons ~/.themes
cp -r icons/* ~/.icons/
cp -r themes/* ~/.themes/

# -----------------------------------------
# 3. Restore GNOME settings
# -----------------------------------------
echo "🧠 Restoring GNOME layout..."
dconf load / < gnome-config/dconf-settings.ini

# -----------------------------------------
# 4. Install GNOME extensions from web
# -----------------------------------------
echo "🌐 Installing GNOME extensions..."

EXTENSIONS=(
    "dash-to-panel@jderose9.github.com|https://extensions.gnome.org/extension-data/dash-to-paneljderose9.github.com.v56.shell-extension.zip"
    "arcmenu@arcmenu.com|https://extensions.gnome.org/extension-data/arcmenuarcmenu.com.v50.shell-extension.zip"
)

EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
mkdir -p "$EXT_DIR"

for ext in "${EXTENSIONS[@]}"; do
    IFS='|' read -r uuid url <<< "$ext"
    echo "📥 Installing $uuid..."
    TMP_DIR=$(mktemp -d)
    curl -Ls "$url" -o "$TMP_DIR/extension.zip"
    unzip -q "$TMP_DIR/extension.zip" -d "$EXT_DIR/$uuid"
    gnome-extensions enable "$uuid"
    rm -rf "$TMP_DIR"
done

# -----------------------------------------
# 5. Done!
# -----------------------------------------
echo "✅ GNOME rice installed successfully!"
echo "🔁 Restart GNOME Shell with: Alt + F2 → r → Enter"
