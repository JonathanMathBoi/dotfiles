# My Dotfiles

## Introduction

This repository serves as a way for me to version control and backup my Arch Linux configuration. It
contains all the configuration files critical to my workflow on Linux.

## How to use

This repository was designed with the use of [GNU Stow](https://www.gnu.org/software/stow/) in mind.

1. Clone this repository into your home directory.

```
git clone https://github.com/JonathanMathBoi/dotfiles.git
```

2. Change directory into this repo.

```
cd dotfiles
```

3. Use GNU Stow to symlink the configuration files to their proper location.

```
stow .
```

## Credits

- SDG (Soli Deo Gloria)
- zDyanTB's [HyprNova dotfiles](https://github.com/zDyanTB/HyprNova) 
    - Used most of their `hyprlock.conf` to make mine.
    - Much inspiration for waybar config
- lgaboury's [Sway waybar install](https://github.com/lgaboury/Sway-Waybar-Install-Script)
    - Copied their waybar weather module and python script
- Dreams of Code
    - Great beginner tmux config tutorial.
      [*Tmux has forever changed the way I write code.*](https://youtu.be/DzNmUNvnB04?si=aIrAnJhVNn3tWHF5)
    - Great tutorial on dotfile management. (The inspiration for this repo.)
      [*Stow has forever changed the way I manage my dotfiles*](https://youtu.be/y6XCebnB9gs?si=6KnujL4hR3DT3mbE)
    - Great tutorial for `zoxide`. (which I use for `cd`)
      [*zoxide has forever improved the way I navigate in the terminal.*](https://youtu.be/aghxkpyRVDY?si=wfni-WZ3MEOVKjLW)
- The Primeagen
    - Excellent crash course in Neovim. The source for the base of my nvim config.
      [*0 to LSP : Neovim RC From Scratch*](https://youtu.be/w7i4amO_zaE?si=8QsyfXWeBeq6a1Dk)

