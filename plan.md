# Plan: Improve Script Structure and Legal Notices

This plan outlines the steps to improve the readability and professionalism of the `gloam.sh` script and the overall project by adding clearer section headers, improving intro text, and adding standard licensing information.

## 1. Documentation & Licensing

### Add `LICENSE` File
- Create a new `LICENSE` file in the root directory.
- Use the MIT License (unless another is preferred) to ensure the project is open-source compliant.

### Update `README.md`
- Add a "License" section at the bottom of the README.

## 2. Script Improvements (`gloam.sh`)

### Improve Intro Text
- Update the header comment at the top of the script to be more descriptive and professional.
- Pull descriptive text and feature summaries from `README.md` to provide a better overview within the script itself.
- Add a Copyright notice (e.g., `Copyright (c) 2024-2026 George Edmo`).
- Add a short License notice (e.g., "This project is licensed under the MIT License - see the LICENSE file for details").

### Clearer Section Headers
The script is currently over 3800 lines. We will add clear, consistent header banners for each major section to improve navigability:

- **HEADER & LICENSE**: Initial script info and legal notice.
- **CONFIGURATION & GLOBALS**: Version info, global variables, and paths.
- **UTILITIES & LOGGING**: Basic helper functions (log, warn, die, cleanup).
- **PATH HELPERS**: Local vs. Global path resolution.
- **UPDATE LOGIC**: GitHub release checking and self-updating.
- **INSTALLATION (GLOBAL/SYSTEM)**: Logic for multi-user and system-wide installs.
- **THEME SCANNING**: Functions that find available themes on the system.
- **THEME GENERATION & BUNDLING**: Logic for creating custom Plasma Global Themes.
- **ASSET MANAGEMENT**: Wallpaper generation and icon/cursor bundling.
- **THEME APPLICATION**: Functions that apply themes to various components (GTK, Kvantum, etc.).
- **SYSTEMD & SERVICE**: Service installation and management.
- **CLI COMMANDS**: Implementation of `toggle`, `light`, `dark`, `status`, etc.
- **MAIN ENTRY POINT**: Argument parsing and execution flow.

## 3. Implementation Steps

1. **Step 1**: Create `LICENSE` file.
2. **Step 2**: Add license section to `README.md`.
3. **Step 3**: Rewrite the header of `gloam.sh`.
4. **Step 4**: Iterate through `gloam.sh` and insert the new section headers.
5. **Step 5**: Verify the script still runs correctly (e.g., `./gloam.sh version`).
