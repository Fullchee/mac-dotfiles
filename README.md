# Mac dot files

## Setup

1. Update macOS
2. Generate an SSH key
   1. `ssh-keygen`
3. Copy the value of the SSH key
   1. `cd ~/.ssh`
   2. `cat ~/.ssh/id_ed25519.pub`
      1. if this changes, update [`.ssh/config`](https://github.com/Fullchee/mac-dotfiles/blob/main/.ssh/config)
4. Add the key to GitHub
   1. https://github.com/settings/keys
5. Install [Homebrew](https://brew.sh/)
   1. Add brew to the PATH
6. Setup the bare git repo

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> ~/.zprofile
config config --local status.showUntrackedFiles no
config remote add origin git@github.com:Fullchee/mac-dotfiles.git
config fetch origin main -y
config reset --hard origin/main
config branch --set-upstream-to=origin/main main
zsh ~/.dotfiles/post-install.sh
```

## Manual steps I haven't automated yet


### Crontab

1. Copy the contents of `.backup-crontab.sh`

```bash
sudo crontab -e
```

#### Saving crontab to dotfiles repo

```bash
save-crontab
```

### Apps

- Bluetooth devices
  - portable speaker
  - headphones
  - earbuds
- Printer
  - [Canon printer driver](https://www.usa.canon.com/internet/portal/us/home/support/details/printers/black-and-white-laser/mf4770n/imageclass-mf4770n?tab=drivers_downloads)
  - [Brother printer driver](https://support.brother.com/g/b/downloadtop.aspx?c=ca&lang=en&prod=hl2240_us_eu)

### Settings

- Settings ->
  - Accessibility
    - Zoom -> Use scroll gesture with modifier keys to zoom
    - Spoken Content
      - System Voice
        - Update the voice to Siri 1
        - Increment speed by 1
      - Speak Selection: enable
  - Control Center
    - Sound: Always Show in Menu Bar
    - Show battery percentage
    - Show Weather
  - Keyboard ->
    - Keyboard Navigation: Enable
    - Keyboard shortcuts
      - Mission Control: disable everything
      - Spotlight -> Show Spotlight Search: disable
  - Trackpad
    - Tap to click
    - -> Scroll & Save: Natural scrolling: disable
  - Login Items & Extensions
    - Actions: enable ImagOptim
  - Location
    - just allow weather and some System Settings to use location
- Screenshot: cmd shift 5 -> Options

## Mac tips

### Finder tips

#### Open with

- [iTerm2](https://gist.github.com/jonschlinkert/7683131911c0cfd18d5cf8e818adffbc)
- VSCode

1. Install the App and place it in the `Applications` folder
2. Hold `Option+CMD` and drag the application to toolbar

- `cmd k` Remote Connect to a server
- `Cmd shift a` `cmd [` jump around and Refresh Finder
- `cmd-shift-n`: create a new folder
- `cmd-L` Create a new alias
- `cmd-shift-g`: Goto file (autocompleted)
- `cmd-shift-.` toggle hidden files
- `alt cmd space` to open up finder

#### Finder Search file type

Type `kind:doc` to only select .doc types

#### Create a "Copy Path" service for Finder (Credit to OSX Daily: http://osxdaily.com/2013/06/19/copy-file-folder-path-mac-os-x/)

1. Launch Automator and create a new “Service”
2. Use the search function to look for “Copy to Clipboard” and drag that into the rightside panel of the Service
3. Set ‘Service recieves selected’ to “files or folders” and ‘in’ to “Finder” as shown in the screen shot below
4. Save the Service with a name like “Copy Path”

### iTerm

- alt -> and <- to move a word at a time (Linux uses the super/meta key)
  1. Preferences (cmd ,) -> Profiles -> Keys -> Left Option as Escape
  2. Change the Alt -> and Alt <- to "Send Escape Sequence" (esc+b and esc+f)
- shortcut to toggle iTerm: Preferences -> Keys tab -> Hotkey section
- cmd-g: find next search result (instead of pressing enter), can also do cmd-shift-g to search forward in time
- http://teohm.com/blog/working-effectively-with-iterm2/
- cmd /: show where the cursor is

### [App not being found by Spotlight?](https://apple.stackexchange.com/questions/236741/single-application-not-showing-up-in-spotlight)

- add and remove whatever is not being found in Spotlight's list of directories it won't scan

### Spotlight: Open the item's containing folder

- cmd-enter

### Word: Change the Default/Normal Layout

1. Select some text with your desired font & spacing
2. Cmd-d (opens Font) window
3. Click the Advanced tab near the top
4. Click `Default ...` on the bottom left

### Word: Don't show start screen

1. Open Preferences (cmd ,)
2. Click the `General` button
3. Untick `Show Word Document Gallery`

### Calendar won't sync

Preferences -> Internet Accounts -> Untick and tick calendar

### Reset SMC (System Management Controller, hardware settings)

1. Turn off laptop
2. Keep Power cable plugged in
3. Hold Shift+Control+Option+Power

### Force Quit a program

- cmd-option-escape, then force quit the program you'd like
- otherwise, to kill the process, `ps aux | grep <process name>` and then kill it, like Linux

### Only copy/paste the formatting (useful in Notes, Google Drive, not Word, especially for strikethrough)

cmd-alt-c and cmd-alt-v

### Change default app for file extension

1. Right click a file with that extension to "Get Info"
2. Near the bottom, in "Open with", change the app and press "Change All..."

### Hide apps (Finder, iTunes, Mail) from the cmd-tab menu

https://apple.stackexchange.com/questions/92004/is-there-a-way-to-hide-certain-apps-from-the-cmdtab-menu

### Modify the icon of a program

1. Create an `.icns` file (convert online or something)
2. Click on your `Application.app` and press `Cmd I`
3. Drag your `.icns` file to the top left corner where the old icon until you see a green plus sign

### Resize Finder column so it fits the text

- double click on the two bars at the bottom of the column
  - like Excel, no need to manually drag it out
