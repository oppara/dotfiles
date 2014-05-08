#!/usr/bin/env bash

# ~/.osx — http://mths.be/osx

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until setup has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

killall Finder
