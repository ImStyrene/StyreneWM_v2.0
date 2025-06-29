# StyreneWM — AutoHotkey Tiling Window Manager

StyreneWM is a lightweight tiling window manager for Windows, purely written in AutoHotkey (v1.1).
It allows you to efficiently manage and tile your windows with keyboard shortcuts — inspired by popular Linux tiling WMs and tailored for Windows power users.

---

## Features

- **Tiling and snapping** windows to screen edges and halves  
- **Resize windows** incrementally with customizable steps  
- **Maximize/Restore toggle** with padding  
- **Window tagging and quick switching** with customizable hotkeys  
- **Window history toggle** to quickly switch between last active windows  
- **Pinned windows (Always on top)** toggle  
- Configurable options through an `.ini` file (padding, animation speed, resize step, etc.)  
- Confirmation prompt when closing windows  
- Easy to extend and customize  

---

## Installation

1. Download [AutoHotkey v1.1](https://www.autohotkey.com/) (if you don’t have it yet)  
2. Place `StyreneWM.ahk` and `StyreneWM.ini` in the same folder  
3. Run `StyreneWM.ahk`  
4. Customize the `StyreneWM.ini` file to adjust padding, resize steps, animation speed, and other settings  

---

## Usage / Keybindings

| Hotkey             | Action                                    |
|--------------------|-------------------------------------------|
| Win + Arrow Keys    | Snap windows to screen edges or halves    |
| Win + Ctrl + Arrows | Resize window in steps (customizable)     |
| Win + M            | Toggle Maximize/Restore with padding       |
| Win + Q            | Close active window (with confirmation)    |
| Win + Z            | Toggle last active window                   |
| Ctrl + Alt + [0-9] | Tag current window to number slot           |
| Win + Ctrl + [0-9] | Activate tagged window from slot            |
| Win + P            | Toggle “Always on Top” (pin window)         |
| Alt + Win + S       | Reload the script                            |

---

## Configuration (`StyreneWM.ini`)
```ini

[Settings]
Padding=10
AnimationSpeed=10
SnapResizeAmount=20
WindowTransparency=255
SnapThreshold=15
MaximizedPadding=5
AutoMaximizeOnOpen=0
```