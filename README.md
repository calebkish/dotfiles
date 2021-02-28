# dotfiles
Contains my Linux user and system configurations

## Set dotfiles for the user you're currently logged in as
Each package is a name of a folder inside `home/`.
```sh
cd home/
stow --verbose --stow --no-folding --target ~ "<packages separated by spaces...>"

# Using short-style option flags:
stow --no-folding -vSt ~ "<packages separated by spaces...>"

# Preview changes before executing:
stow --no-folding -nvSt ~ "<packages separated by spaces...>"
```

## Set system-level dotfiles
Each package is a name of a folder inside `system-arch/`.
```sh
cd system-arch/
sudo stow --no-folding -vSt / "<packages separated by spaces...>"
```

## Set tridactylrc
Once the Tridactyl extension is installed in Firefox, run:
```
:source --url https://raw.githubusercontent.com/calebkish/dotfiles/master/firefox/tridactylrc
```
