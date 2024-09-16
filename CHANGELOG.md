# Changelog

## [1.1.1] - 2024-09-16

### Changed
- **API Reference**: Updated the API reference documentation for clarity and consistency.

---

## [1.1.0] - 2024-09-16

### Added
- **Animations**: Introduced multiple new animation types for content transitions:
  - `fade`: Fades the content in and out.
  - `slide`: Slides the content in and out horizontally.
  - `scale`: Scales the content from smaller to normal size.
  - `rotate`: Rotates the content.
  - `flip`: Adds a 3D flip animation effect.
  - `fadeScale`: Combines both fade and scale animations.
  - `slideFade`: Combines both slide and fade animations.
  - `bounce`: Adds a bounce effect for content entrance.
  - `shrink`: Shrinks the content in and out.
  - `blur`: Adds a blur effect to the content.

### Changed
- **Animations Control**: The `_initializeAnimations()` function has been updated to dynamically handle the newly added animations for smooth and flexible transitions.
- **Custom Header**: Added more flexible customizations to the accordion header, including:
  - `headerTextColor`: Set custom colors for the header text.
  - `headerTextAlign`: Control the alignment of the header text (left, center, right).
  - `headerPadding`: Customize padding around the header.
- **Content Styling**: Enhanced customization options for content:
  - `contentBackgroundColor`: Allows setting a background color for the content area.
  - `contentGradient`: Added support for gradients in the content area.
  - `contentBorder`: Allows setting a custom border for the content area.
  - `contentImage`: Enables adding an image to the background of the content.
  - `contentBorderRadius`: Customize the border radius of the content area for rounded corners.
  - `contentAlignment`: Align the content inside the accordion with custom alignment.

### Fixed
- Fixed issue where content height was not properly adjusting based on the number of widgets inside the accordion.
- Resolved problems with animation not completing properly when switching between different accordion states.

### Removed
- None.

---

## [1.0.0] - 2024-09-12

### Initial Release
- Added basic accordion functionality.
- Supported animations: `fade`, `slide`, `scale`.
- Customizable header with `headerTitle`, `headerLeading`, `headerTrailing`, and more.
