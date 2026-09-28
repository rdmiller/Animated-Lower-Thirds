# Animated-Lower-Thirds
Animated Lower Thirds with dockable Control Panel - OBS Tool

## Description
With this tool you can use a control panel, docked in OBS, to add and change your own lower thirds on the fly. It works out of the box; basic knowledge of HTML, JavaScript and CSS only helps if you want to customize it further.
The control panel and the lower thirds (a browser source) talk to each other with the BroadcastChannel API.

This project is based on [Lower thirds in HTML/CSS](https://obsproject.com/forum/resources/lower-thirds-in-html-css.928/), and [Animated lower thirds with control panel](https://obsproject.com/forum/resources/animated-lower-thirds-with-control-panel.922/).

![Lower Thirds Screenshot](https://obsproject.com/forum/attachments/screen-jpg.61515/)

### Features
- 4 different lower thirds on screen at the same time
- 10 memory slots for each lower third (name, info and logo)
- 4 predefined styles
- Highly customizable: colors, fonts (including Google Fonts), logos, sizes, margins, borders, shadows, timing and automation
- Safe editing while live: changes to a lower third that is on air only go on air when you take them
- Clear status in the control panel: **ON AIR** / **STANDBY** for each lower third, and whether the output (the browser source) is running
- Hotkeys for the switches and memory slots (optional OBS script)
- Preview window, 3 control panel themes, and backup / restore of all settings

## Installation
1. Download the Zip file and unzip it somewhere it can stay (OBS loads the files from there).
2. **Add the lower thirds to your scene:** add a **Browser** source, check **Local file**, choose `lower thirds/browser-source.html`, and set the size to your canvas (e.g. 1920 × 1080).
3. **Dock the control panel:** open **Docks → Custom Browser Docks…** (in older OBS versions: **View → Docks → Custom Browser Docks…**), give it a name, and as URL enter the full path of `lower thirds/control-panel.html` as a file URL, for example `file:///C:/Tools/Animated-Lower-Thirds/lower thirds/control-panel.html`.
4. *(Optional)* **Hotkeys:** in **Tools → Scripts**, add `lower thirds/lower-thirds_hotkeys.lua`. Then set your keys in **Settings → Hotkeys** ("Main Switch", "Lower Third Switch #1", "Load Slot #1 on LT#1", …).

When everything is connected, the Main settings header of the control panel shows **● OUTPUT OK**. If it shows **● NO OUTPUT**, the browser source isn't running: check that it is in the current scene (or turn off "Shutdown source when not visible").

Video guide: https://youtu.be/tddMYWya7O0

### Requirements
OBS Studio with Custom Browser Docks. Older OBS versions only offered browser docks on Windows; current versions also have them on macOS and Linux.

## Usage
- **Switches.** The main switch enables the lower thirds; each lower third has its own switch. A lower third shows for its *active* time, hides for its *inactive* time, and repeats. The times (in seconds: in-out animation, active, inactive) are set for all in Main settings, or per lower third under its clock icon. The lock keeps it on screen; one-shot turns its switch off after one appearance.
- **Status.** A lower third on screen glows red and shows **ON AIR**; one that is switched on but waiting off screen glows amber and shows **STANDBY**.
- **Editing while on air.** Typing in the Name or Info of a lower third that is on air doesn't change what viewers see. The field gets an amber outline and a bar says *Edited, not on air yet*: press **Enter** or **Take** to put the edit on air, or **Esc** / **Undo** to discard it. A pending edit is also applied by itself once the lower third has left the screen. When it is off air, edits apply right away.
- **Memory slots.** Click an empty slot to save the current name, info and logo; click a stored slot to load it; click and hold to delete it. With autotrigger (⚡) loading a slot also switches the lower third on; with autoload (⟳) the next slot is loaded every time it goes off screen.
- **Appearance.** Open a lower third (+) to change its style (1–4), alignment, size, margins, text sizes and line spacing, font, logo, colors, borders and shadows.
- **Main settings.** *Appearance*: control panel theme and display options. *Customs*: add fonts from Google Fonts, and change the default logos (copy the image files into the `logos` folder first). *System*: back up, restore and reset.
- **Backup.** *Export* copies all settings to the clipboard; paste them into a text editor and save them as a `.txt` file. *Import* reads such a file, and only replaces your settings if it is a valid backup.

A few layout options are still set in CSS: at the end of `common/css/style-source.css` you can uncomment rules for multi-line texts, lower thirds at the top of the screen, and a full-width background for style 1.

## Project structure
| File | What it is |
|---|---|
| `lower thirds/control-panel.html` | The control panel (dock). One panel template is copied for each lower third. |
| `lower thirds/browser-source.html` | The lower thirds output (browser source). |
| `lower thirds/lower-thirds_hotkeys.lua` | Optional OBS script: hotkeys write `common/js/hotkeys.js`, which the control panel watches. |
| `common/css/style-source.css` | Look and animations of the lower thirds and their styles. |
| `common/css/style-control_panel.css`, `common/css/themes/` | Look of the control panel and its themes. |
| `common/js/jscolor.js` | Color picker. |
| `logos/` | Default logos. |

Notes for contributors:
- The control panel sends every setting of lower third *N* as `alt_N_<setting>` on the `obs-lower-thirds-channel` BroadcastChannel; the browser source answers with its status every second on `obs-lower-thirds-channel2`; custom fonts go on `obs-lower-thirds-fonts`.
- Both pages are plain JavaScript (no jQuery), and their code is written once and repeated for each lower third (`LOWER_THIRDS_COUNT`). The CSS still defines exactly 4 lower thirds.
- To add a style: add its `.style-N` rules in `style-source.css`, a row in `STYLE_RESTRICTIONS` in the control panel (which controls the style supports), and raise the `max` of the style selector in the panel template.

## Support
You can find all videotutorials on this [Youtube Channel](https://www.youtube.com/channel/UCUYiOIl-DHn8B1eRzUfDyyw)

## Translations

[Portugues (Brasil)](https://github.com/eudanielhenrique/Animated-Lower-Thirds/tree/tradu%C3%A7%C3%A3o-pt-br)</br>
[Inglês](https://github.com/noeal-dac/Animated-Lower-Thirds)

## Contributing
I am a designer and my scripting knowledge is few. I made this tool (Frankenststool) because I needed it and I want to share it. You are welcome to improve it. I am aware that many parts of the code can make any expert cry. I'm really sorry :P

## Donations
If you like the extension and you want to support the development - please consider to donate by [Paypal](https://paypal.me/noealdac). Any donations are greatly appreciated.

## License
The Animated Lower Thirds source code is made available under the [MIT license](https://github.com/noeal-dac/Animated-Lower-Thrids/blob/master/LICENSE).
