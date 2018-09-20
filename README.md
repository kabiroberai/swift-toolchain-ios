# swift-toolchain

Swift toolchain for iOS

## Installation

1. Install any requirements listed in `https://github.com/apple/swift/blob/swift-<version>-RELEASE/README.md#macos`
2. Clone this repository somewhere on your computer
3. Run `./prepare-toolchain <version> <path to required Xcode.app>`

### Packaging as a .deb

    make package

### Installing

    make install THEOS_DEVICE_IP=<ip>
