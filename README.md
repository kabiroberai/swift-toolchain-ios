# swift-toolchain

Swift toolchain for iOS

## Installation

1. Install any requirements listed in `swift-<major>.<minor>-branch` of [apple/swift](https://github.com/apple/swift)
2. Clone this repository somewhere on your computer
3. Run `./prepare-toolchain <major> <minor> <patch> <path to required Xcode.app>`

### Packaging as a .deb

    make package

### Installing

    make install THEOS_DEVICE_IP=<ip>
