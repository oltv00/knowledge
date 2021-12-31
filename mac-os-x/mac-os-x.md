# Mac OS X

* [File manager](#file-manager)
* [Web](#web)
* [Communication](#communication)
* [Productivity](#productivity)
* [Oragization](#oragization)
* [etc](#etc)
* [Development](#development)
* [Console utilits](#console-utilits)

## File manager

* Finder

## Web

* Safari

Extensions:

```zsh
1 Password
Ghostery
PIPer
Adguard
Pocket
```

## Communication

* Mail
* Calendar
* Slack
* Skype
* Twitter
* WhatsApp
* Telegram
* VK Messenger
* TweetDeck

## Productivity

* 2Do
* Yandex.Disk
* Google.Drive
* Amphetamine
* 1Password
* TeamViewer
* Flux
* TogglDesktop
* The Unarchiver
* Keka
* WWDC
* VPNs
  * TunnelBear
  * VyprVPN
  * FreeVPN [freevpn.pw](freevpn.pw)
* Monosnap
* iStat Menus 6
* Karabiner
* Folx
* Gimp
* IINA
* 5KPlayer

* [Rectangle](https://github.com/rxhanson/Rectangle)

```zsh
brew cask install rectangle
defaults write com.knollsoft.Rectangle minimumWindowWidth -float 0.1
defaults write com.knollsoft.Rectangle minimumWindowHeight -float 0.1

defaults write com.knollsoft.Rectangle almostMaximizeHeight -float 0.9
defaults write com.knollsoft.Rectangle almostMaximizeWidth -float 0.7

Additional functionality (https://github.com/oltv00/Rectangle/tree/feature/specified-window-action)
CMD + OPTION + CTRL + SHIFT + C
defaults write com.knollsoft.Rectangle specified -dict-add keyCode -float 8 modifierFlags -float 1966080
defaults write com.knollsoft.Rectangle specifiedHeight -float 1050
defaults write com.knollsoft.Rectangle specifiedWidth -float 1680
```

* Bartender 3

```zsh
To fix mac os menu bar order
~/Library/Preferences/com.apple.systemuiserver.plist
```

* Alfred

```zsh
clean_derived_data
Safari*Assistant * for Safari
Search Safari and Chrome Tabs * for Google Chrome
spotifyminiplayer
Translate
tunnelblick_toggle
DarkOrLight
tty
```

## Oragization

* Notes
* Notion
* Evernote
* Numbers / Keynote / Pages
* Word / Excel / PowerPoint
* iMovie
* VLC

## etc

* Spotify

## Development

* VCS
  * SourceTree
  * Fork
* iTerm
* Zeplin
* Figma
* Sublime Text
* Postman
* Microsoft Remote Desktop
* Dash
* JetBrains Toolbox
* Xcode
* AppCode
* VSCode
* Docker
* Reveal
* [GPG Suite](https://gpgtools.org/)
* Proxyman
* DevCleaner

## Console utilits

* brew
* rvm
* fastlane

```zsh
brew cask install fastlane
```

* gnupg gnupg2

```zsh
brew install gnupg gnupg2
```

* oh my zsh
* vim

```zsh
brew install vim
```

* tmux

```zsh
brew install tmux
```

* [Powerline fonts](https://github.com/powerline/fonts)
* Fire Code

## Additional setup

* Console commands:

```zsh
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSScrollAnimationEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write -g NSScrollViewRubberbanding -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true
```
