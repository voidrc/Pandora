# Changelog

## v0.23.3 - 2025-07-22

- Fixed string storage type in Go

## v0.23.2 - 2025-07-22

- Fixed highlighting of assignment operator

## v0.23.1 - 2025-07-20

- Fixed syntax highlighting for char literals (single quotes) in Rust
- Corrected assignment operator highlighting in Rust code

## v0.23.0 - 2025-07-18

- Added new variant with yellow accent color
    - `Monochromator Dark Sulfur`
    - `Monochromator Light Sulfur`
- Added status bar error and warning background colors to theme

## v0.22.0 - 2025-07-15

- Improved color readability:
    - Adjusted purple in dark themes (`#c61aff` -> `#ee40ff`)
    - Adjusted green in light themes (`#26a269` -> `#017f45`)
- Fixed "Plain" theme variants by correcting values that should have been changed in `v0.18.0`

## v0.21.0 - 2025-07-04

- Added x86_64, ARM, RISC-V, MIPS support for the following OpenVSX extensions:
    - x86_64: `13xforever.language-x86-64-assembly`, `basdp.language-gas-x86`
    - ARM: `dan-c-underwood.arm`
    - RISC-V: `sunshaoce.RISC-V`
    - MIPS: `kdarkhan.mips`

## v0.20.1 - 2025-06-16

- Fixed backtick symbol in Markdown for accent color variants

## v0.20.0 - 2025-06-13

- Fine-tuned Markdown and LaTeX highlighting
- Improved JavaScript string interpolation

## v0.19.0 - 2025-06-12

- Added new variant with purple accent color
    - `Monochromator Dark Amethyst`
    - `Monochromator Light Amethyst`

## v0.18.0 - 2025-06-11

- Improved shade of blue to be more visible
- Improved string highlighting
- Fixed C++ pointers
- Fixed `self` and entity names in Rust
- Fixed enums and function arrows in Java
- Fixed constants in Haskell, Perl, Ruby, PHP, ...
- Fixed support functions in Lua, Julia, ...
- Fixed strings and symbols in F#
- Fixed null and booleans in Zig
- Decreased minimum VS code engine version

## v0.17.2 - 2025-06-05

- Fixed Doxygen comments for languages other than C++

## v0.17.1 - 2025-06-03

- Fixed Code Actions Menu

## v0.17.0 - 2025-05-25

- Added `Monochromator Dark Plain` and `Monochromator Light Plain`
- Corrected the syntax highlighting for backslashes that precede LaTeX keywords
- Redesigned extension icon

## v0.16.0 - 2025-05-24

- Bold formatting limited to keywords only (functions no longer bolded)
- String quotation marks now match literal text color
- Preprocessor directive styling reverted to pre-`0.15.0` appearance
- Enhanced YAML file appearance
- Documentation keywords now display in italics
- Fixed hex code highlighting issues in HTML

## v0.15.2 - 2025-05-19

- Fixed highlighting of SQL database names and table names

## v0.15.1 - 2025-05-17

- Fixed highlighting of `storage.modifier.sql`

## v0.15.0 - 2025-05-10

- Fixed LaTeX math mode
- Fixed more constants
- Various QOL improvements
    - Documentation keywords bold and gray (also things like `@Override` in Java or shebangs)
    - Preprocessor directives are now bold and gray
    - Better highlighting for escaped characters
    - HTML and CSS tags are now bold

## v0.14.1 - 2025-05-08

- Fixed unit highlighting (such as "px" in CSS)
- Fixed variable highlighting of shell scripts and JavaScript
- Fixed punctuation highlighting of some characters in Java and R
- Fixed regex highlighting

## v0.14.0 - 2025-05-04

- Added the following themes:
    - `Monochromator Dark Amber`
    - `Monochromator Dark Emerald`
    - `Monochromator Dark Ruby`
    - `Monochromator Light Amber`
    - `Monochromator Light Emerald`
    - `Monochromator Light Ruby`
- Highlighted timestamps as literals
- Reduced contrast of `editor.wordHighlightStrongBackground`

## v0.13.3 - 2025-05-04

- Fixed highlighting of preprocessor names and hexadecimal numbers

## v0.13.2 - 2025-04-22

- Fixed highlighting in Python, Typescript, LaTeX, YAML and TOML

## v0.13.1 - 2025-04-21

- Corrected selection highlighting
- Fixed inconsistencies
- Removed redundant code

## v0.13.0 - 2025-04-18

- Fixed highlight color of selections in minimap
- Changed `scrollbarSlider.background` to match `editorGroupHeader.tabsBackground`
- Changed `textCodeBlock.background` to match `textBlockQuote.background`
- Changed icon design
- Changed colors to match https://gitlab.gnome.org/GNOME/libadwaita/-/merge_requests/1317
    - `#1e1e1e` -> `#1d1d20`
    - `#242424` -> `#222226`
    - `#303030` -> `#2e2e32`
    - `#3f3f3f` -> `#424246`
    - `#dfdfdf` -> `#d9d9da`
    - `#ebebeb` -> `#ebebed`
    - `#f5f5f5` -> `#f2f2f4`

## v0.12.0 - 2025-04-16

- Darkened shade of blue in `Monochromator Dark`
- Reduced use of bold emphasis
- Integrated selections into the theme
- Fixed highlighting of constants (has been wrong in e.g. Rust)
- Improved Markdown preview
- Fixed lightbulb color to finally display in the right shade of gray
- Changed icon design
- Added badges to `README.md`
- Removed redundant code

## v0.11.1 - 2025-04-10

- Fixed tabs color
- Fixed screenshots

## v0.11.0 - 2025-04-10

- General UI overhaul
- Added color for `gitDecoration.addedResourceForeground`

## v0.10.3 - 2025-03-24

- Fixed dropdown background color
- Decreased contrast of inlay hints

## v0.10.2 - 2025-03-23

- Fixed color of ...
    - Scrollbar slider
    - Panel title
    - Fold background

## v0.10.1 - 2025-03-21

- Replaced `icon.png` with `icon128.png` and `icon1024.png`
- Merged screenshots
- Beautified `README.md`
- Fixed changelog formatting

## v0.10.0 - 2025-03-21

- Added boldness solely for `constant.language`
- Fixed menu selection color in light theme
- Increased overall contrast
- Improved look of ...
    - Activity bar
    - Command palette
    - Keybindings

## v0.9.0 - 2025-03-21

- Integrated more components to fit the theme such as ...
    - Checkboxes
    - Breadcrumbs
    - Git decoration for ignored files
    - Indent guides
    - Sticky scroll shadow
    - Menu (which is displayed when you right-click)
    - Widgets
    - Notifications
- Simplified changelog format
- Set semantic highlighting to true
- Fixed missing hashtag for hex code
- Removed boldness of constants
- Revoked changes of `v0.8.4`

## v0.8.4 - 2025-03-17

- Fixed color for inactive background
    - `titleBar.inactiveBackground` from `#ebebeb` to `#f0f0f0` in light theme
    - `titleBar.inactiveBackground` from `#303030` to `#2a2a2a` in dark theme

## v0.8.3 - 2025-03-07

- Added download section to `README.md`
- Added bugs section to `package.json`
- Changed name of `logo.png` to `icon.png`
- Changed structure of screenshots (created a directory for screenshots)
- Changed structure of `README.md`
- Fixed formatting in `CHANGELOG.md`

## v0.8.2 - 2025-03-06

- Changed info color to match theme

## v0.8.1 - 2025-03-02

- Fixed screenshots in `README.md` by changing the git repository

## v0.8.0 - 2025-03-02

- Added `CHANGELOG.md`
- Added more information, a "License" section and screenshots to `README.md`
- Added theme colors to support Markdown better (in the editor)
- Changed font in logo from "Fira Code" to "IBM Plex Mono"
- Made color of progress bars less aggressive
- Improved readability by changing the colors of URLs to blue
- `textBlockQuote` for better readability (in Markdown Preview)
- Fixed color of `focusBorder` in the dark theme

## v0.7.0 - 2025-02-28

- Added theme colors to ...
    - Source control page
    - Code lens
    - Indent guide
    - Inlay hint
    - Suggest widget
    - Extension button
    - Git decoration
    - Input background
    - Markdown preview
- Changed color of literals to blue for dark and light theme

## v0.6.0 - 2025-02-27

- Changed color of borders
- Changed colors of errors and warnings in the minimap

## v0.5.0 - 2025-02-24

- Added theme colors to ...
    - Icons
    - Progress bar
    - Badges
    - URLs
- Changed git colors to make them more vibrant
- Changed some colors to fit in better with the theme

## v0.4.0 - 2025-02-21

- Changed logo to fit in with the new theme changes
- Changed git decorations to make them more readable
- Changed color of light theme to magenta

## v0.3.0 - 2025-02-15

- Added one color for literals
- Added terminal colors
- Changed logo to fit in with the new theme changes
- Removed high contrast variants

## v0.2.0 - 2025-02-08

- Added high contrast variants
- Improved theme colors
- Fixed font in logo

## v0.1.0 - 2025-02-08

- Added `LICENSE`
- Added `README.md`
- Added Monochromator Dark
- Added Monochromator Light
