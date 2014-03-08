#!/bin/bash
#Description: Install i386-jos toolchain on OSX

brew tap t3rm1n4l/homebrew-gcc_cross_compilers
brew install i386-elf-binutils
brew install i386-elf-gcc
brew install i386-elf-gdb
