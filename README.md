<div align="center">
  <h1>gloam</h1>
  <p><b>Syncs Kvantum, GTK, and custom scripts with Plasma 6's native light/dark (day/night) theme switching - and more.</b></p>
  <img src="screenshots/example.gif" width="800" />
</div>

**gloam** ensures your entire Linux desktop follows KDE Plasma's Day/Night cycle.

While Plasma 6 handles its own themes well, other applications often get left behind. Gloam runs quietly in the background, bridging the gap between Plasma's native theme switching and the rest of your system.

## Why use gloam?

*   **Total Consistency:** Forces Kvantum, GTK apps, Flatpaks, and Konsole to switch themes instantly alongside Plasma.
*   **Native Integration:** Works with Plasma's built-in "Night Color" or manual Global Theme switching. No separate scheduler required.
*   **Custom Global Themes:** Automatically bundles your favorite cursor, icon, and window decoration choices into a proper Plasma Global Theme.
*   **Scriptable:** Executes your own custom scripts whenever the theme changes (great for switching wallpapers, restart services, etc.).
*   **Panel Widget:** Includes a handy panel icon to manually toggle light/dark mode with one click.

## Installation

Clone the repository and run the setup wizard:

```bash
git clone https://github.com/edmogeor/gloam.git
cd gloam && ./gloam.sh configure
```

The wizard will scan your installed themes and ask you to pick your preferred **Light** and **Dark** combinations. It then creates a systemd service to watch for changes automatically.

## Usage

Once configured, **gloam works automatically**. You don't need to do anything.

If you want to manually control it or change settings, use the CLI:

```bash
gloam configure     # Re-run the setup wizard
gloam toggle        # Switch between Light/Dark mode (or use Meta+Shift+L)
gloam status        # See what's currently active
gloam remove        # Uninstall everything
```

### Partial Re-configuration
You can update specific settings without re-running the whole wizard:

```bash
gloam configure --kvantum      # Change Kvantum themes
gloam configure --gtk          # Change GTK themes
gloam configure --script       # Update custom scripts
gloam configure --widget       # Reinstall panel widget
```

## Flatpak Support
Gloam automatically configures permissions for Flatpak apps to read your theme folders.
*   **Note:** You must restart running Flatpak apps for theme changes to take effect.
*   If using Kvantum with Flatpaks: `flatpak install org.kde.KStyle.Kvantum`

## Seamless Qt Refresh (Optional)
Standard Qt apps might not refresh instantly without a restart. For a smoother experience, you can install the [plasma-qt-forcerefresh](https://github.com/edmogeor/plasma-qt-forcerefresh) patch.

## Day/Night Wallpapers
Gloam leaves wallpaper management to Plasma 6, which supports this natively.

To use it:
1.  Go to **System Settings > Wallpaper**.
2.  Choose a "Dynamic" wallpaper (often marked with a clock icon).
3.  Set "Switch dynamic wallpapers" to **"Based on whether Plasma style is light or dark"**.