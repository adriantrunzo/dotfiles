#!/bin/bash

echo "Prerequisites: sudo access and Xcode/command-line tools."
read -p "Continue? (y/n) "
if [[ $REPLY != [yY] ]]
then
    echo "Exiting OS X setup."
    exit 0
fi

# Install homebrew and set appropriate path
export PATH=/usr/local/bin:$PATH
which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

which stow || brew install stow
which markdown || brew install markdown
which mysql || brew install mysql
which pass || brew install pass

if ! brew ls python &> /dev/null; then brew install python; fi
if ! brew ls python3 &> /dev/null; then brew install python3; fi
if ! brew ls vim &> /dev/null; then brew install vim; fi
if ! brew ls git &> /dev/null; then brew install git; fi
if ! brew ls coreutils &> /dev/null; then brew install coreutils; fi

# Install brew cask and some extras
brew tap caskroom/cask
brew tap caskroom/fonts

brew cask install google-chrome
brew cask install kindle
brew cask install skype
brew cask install spotify

brew cask install font-source-code-pro
brew cask install font-sauce-code-powerline

# App Store: Automatically check for new updates, download them in the
# background and install security/OS updates as well
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
defaults write com.apple.commerce AutoUpdate -bool true

# App Store: Allow rebooting for updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

# Dock: Set tile size and pin left
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock orientation -string left

# Dock: Minimize to app icon, show indicators and not launch animations
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock launchanim -bool false

# Dock: Use scale effect for minimizing applications
defaults write com.apple.dock mineffect -string "scale"

# Finder:  Show all file extensions, status bar, path and posix path
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Finder: Search current firectory by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: Don't warn about extension changes
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: Show item info below icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Finder: Arrange by name on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist

# Finder:  Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# Finder: Don't hide ~/Library or /Volumes
chflags nohidden ~/Library
sudo chflags nohidden /Volumes

# General: Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# General:  Reduce Transparency in menu bar and elsewhere
defaults write com.apple.universalaccess reduceTransparency -bool true

# General: Save to disk, not iCloud, by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# TextEdit: UTF-8 by default and plaintext for new documents
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Terminal: Use UTF-8 in Terminal
defaults write com.apple.terminal StringEncodings -array 4

# Terminal: Don't automark commands
defaults write com.apple.Terminal AutoMarkPromptLines -int 0

# Terminal: Set Solarized Dark Theme and Source Code Pro Font
osascript setup/set-terminal-theme.applescript

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
