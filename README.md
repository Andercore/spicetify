<p align="center">
  <img src="docs/spicetify.ico" alt="Spicetify logo" width="128">
</p>

# 🎵 Spicetify Menu

I created this Windows menu to install, update, and remove Spicetify for the
Spotify desktop application. The original source was published in a Gist and
is now included directly in this repository as
[`Spicetify_Menu.cmd`](Spicetify_Menu.cmd).

> **Author:** I created and maintain the original code in this project.

## ✅ Requirements

- 🪟 Windows 10 or Windows 11
- 🎵 The Spotify desktop application
- 🖥️ A regular desktop installation of Spotify
- 📄 The script saved with the `.cmd` or `.bat` extension

This menu is not intended for the Spotify web player or the Microsoft Store
version of Spotify. Do not run the script as Administrator.

## 🚀 Tutorial

### 1️⃣ Install Spotify

If Spotify is not installed, download it from the
[official Spotify download page](https://www.spotify.com/download/windows/).
Open Spotify once after installation, then close it before running the menu.

### 2️⃣ Download the menu

1. Open the [latest release](../../releases/latest), or download
   [`Spicetify_Menu.cmd`](Spicetify_Menu.cmd) from this repository.
2. Click **Raw**, then save the file with the `.cmd` extension.
3. Keep the file in a normal folder such as `Downloads\Spicetify`.
4. Double-click the file to start it.

Do not use **Run as administrator**. The script checks this automatically and
stops if it detects an elevated console.

### 3️⃣ Confirm Spotify

When the program asks whether the Spotify desktop application is installed,
press **Y** to continue or **N** to close the menu.

### 4️⃣ Choose an operation

The menu provides four options:

| Option | Action |
| --- | --- |
| `1` | Install Spicetify and the Marketplace |
| `2` | Update Spicetify and reapply the backup |
| `3` | Restore Spotify and uninstall Spicetify files |
| `0` | Exit |

Type the option number and press the corresponding key. The script displays
each operation in a separate console message.

### 5️⃣ Confirm the installation

After installation, the menu asks whether everything worked:

- Press **Y** to return to the menu.
- Press **N** to restore Spotify and retry the installation.

The uninstall option also asks for confirmation before removing Spicetify
data from `%APPDATA%\spicetify` and `%LOCALAPPDATA%\spicetify`.

## 🧰 What the script does

- Installs Spicetify from the official Spicetify installer.
- Installs the official Spicetify Marketplace installer.
- Runs `spicetify backup`, `apply`, `clear`, `restart`, and `restore` as needed.
- Updates Spicetify with `spicetify upgrade`.
- Removes the local Spicetify folders during uninstall.

The script uses only the official installer URLs:

- [Spicetify CLI installer](https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1)
- [Spicetify Marketplace installer](https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1)

## 🧪 Last tested versions

The original Gist was tested on **20 May 2025** with:

- ✅ Spotify `1.2.62.580.gb27ad23e`
- ✅ Spicetify `v2.40.9`

Spotify and Spicetify change over time. If an update breaks the script, first
use the **Update** option or check the official Spicetify documentation.

## 📄 Source code

The complete source is available in
[`Spicetify_Menu.cmd`](Spicetify_Menu.cmd). The file is intentionally kept as
a plain Windows command script so it can be inspected before execution.

## 📄 License

All rights reserved. See [LICENSE](LICENSE).
