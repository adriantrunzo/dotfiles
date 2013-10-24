#!/bin/bash
set -e

echo "Prerequisites: sudo access and Xcode/command-line tools"
read -p "Continue? (y/n) "
if [[ $REPLY != [yY] ]]
then
    echo "Exiting OS X setup"
    exit 0
fi

# install homebrew and set appropriate path
export PATH=/usr/local/bin:$PATH
which brew || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

which git || brew install git
which hg || brew install hg
which stow || brew install stow
which markdown || brew install markdown
which mysql || brew install mysql

if ! brew ls python &> /dev/null; then brew install python --framework; fi
if ! brew ls vim &> /dev/null; then brew install vim; fi

pip install pyflakes

# Swith login shell to zsh
chsh -s /bin/zsh `whoami` #defaults write com.apple.terminal Shell -string "/bin/zsh"

# Use UTF-8 in Terminal
defaults write com.apple.terminal StringEncodings -array 4

# Copy patched font into place
mkdir -p ~/.fonts
cp ~/.fonts/Ubuntu-Mono-Powerline.otf ~/Library/Fonts/

# Use solarized as the default theme
open ".terminal-solarized/Solarized Dark.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Default Window Settings" -string "Solarized Dark"
defaults write com.apple.terminal "Startup Window Settings" -string "Solarized Dark"




## General UI/UX

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "$1"
sudo scutil --set HostName "$1"
sudo scutil --set LocalHostName "$1"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$1"

# Menu Bar: no transparency, keep useful menus
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false


## Trackpad, mouse, keyboard, Bluetooth accessories, and input

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


## Finder 

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show item info below icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
chflags nohidden ~/Library


## Dock

# Set the icon size of Dock items to 38 pixels
defaults write com.apple.dock tilesize -int 38

# Left orientation
defaults write com.apple.dock orientation -string left

# Pin the dock in the corner
defaults write com.apple.dock pinning -string end

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true



## Text Edit

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4


## Cleanup

# Kill affected applications
for app in "Dock" "Finder" "Safari" "SystemUIServer" "iTunes"; do
	killall "$app" > /dev/null 2>&1
done
echo "Logout/restart for some of these changes to take effect."
