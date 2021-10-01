# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added shortcut for GameObject().getTraitManager().getTrait(...) to improve project readability.
- Added methods to remove GameObject from Scenes, Initiative and Turns.
- Added isRelated method for ActionBuilder.
- Tilts removed in the end of the Scene.
- Added equals method for Accessor.

### Changed

- Throw NoWillpowerException when no willpower left, or you can't use it.

### Fixed

- Fix Head target required deal more than size to cause StunnedTilt. 