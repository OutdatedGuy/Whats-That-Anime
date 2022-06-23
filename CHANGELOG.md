# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2022-06-23

### New features

- `Web` platform support.
- (Android) App displays from edge to edge.

### Added

- Link to **_API Creator_** in _Settings_ page.

### Changes

- Changed _Video Player_.
- Removed `BottomNavigationBar` hover color.

### Improvements

- Reduced app size.
- Controls not hidden when video is playing if video duration is 0.

### Fixed

- (Android) _Status bar_ text not visible for some pages.
- (Android) Hidden _status bar_ on splash screen.
- (Android) Not transparent _system nav_ and _status bar_ colors from API 28+.
- Image size limit warning value not correct.
- _Hitory_ and _Settings_ page not refreshed when user signs in.
- `ListView` padding not correct.

## [1.0.1] - 2022-06-21

- (Android) **FIX**: Splash screen not shown in fullscreen mode.
- **REFACTOR**: Removed **_select from camera_** option as search results were not useful.

## [1.0.0] - 2022-06-17

- Initial Release
