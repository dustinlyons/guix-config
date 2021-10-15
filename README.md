# guix-config
## Screenshot

![Desktop in October, 2021](res/Desktop.png) 

## What is this?
#### _tl;dr The "functional programming" equivalent of operating systems_
The configuration of my operating system, Guix Linux, and day-to-day software (who are we kidding, emacs) defined in literate configuration style. 

1. The .org files represent the code itself. 
2. Makefile is used to [tangle](https://orgmode.org/worg/org-contrib/babel/intro.html) the code into seperate files of which are primarily Scheme, ELisp, and shell scripts.
3. Finally, the Guix daemon interprets these files to generate everything from my desktop and laptop, to servers running in a rack or VMs inside of a hypervisor. _(coming soon)_

No more traditional dotfiles. Hello Scheme and literate configuration.

## Why?
With everything defined in this way I can treat my system as one program. It's 100% reproducible, bit by bit. My environments across laptop
and desktop are exactly the same, staying in sync without headache. This is the way.

Every change to my system is now deployed from the [Guix Store](https://guix.gnu.org/manual/en/html_node/The-Store.html) thanks to [Guix Home](https://guix.gnu.org/manual/devel/en/html_node/Home-Configuration.html). This means I get rollbacks, transcational upgrades, fine-grained profiles, and other guix goodness with even my dotfiles.

Other advantages: 
- theming now becomes easier. It's all here, I can define one set of colors, fonts, or margins to be used everywhere. Technically possible before but again, don't want to pull my hair out.
- no more "polutting" my system with experiments. I can try different blockchain projects, work with a client that needs .NET, or do anything I want without feeling like I need to clean it up later.
- Scheme is fun to hack on, and I hack on my home-lab for fun

Learn more about Guix [here](https://guix.gnu.org/).

## Installation
This project isn't intended for outside use yet; please just use as an example. I use Makefile to tangle org files into their own configs and then ```guix system reconfigure``` to inject those config files into ```.config```, create symlinks, set environment variables, etc. 

#### Generate a ```build``` directory that contains all guix and dotfile configuration

```sh
$ make
```

#### Install new configuration and move system to next generation
```sh
$ make install
```

## Files and Organization
I use inheritance to share configuration between my machines where it makes sense. This is subject to change as I make progress, acquire new machines, setup new VMS, etc.

### Workstation.org
###### Base File
Base definition of machines I'll work on day-to-day. Includes core system functions like the kernel, libinput, X Window System, etc. This is to seperate configuration concerns from machines I have running in my home-lab, but keep things shared between my Desktop and Laptop.

### Workstation-Desktop.org
###### Inherits from `Workstation`
Sensible definitions for my Desktop machine that are likely to never change. Includes Openbox configuration, users and filesystems for Desktops, more dotfiles and package configuration.

### Workstation-Laptop.org
###### Inherits from `Workstation` _(Coming soon!)_
Sensible definitions for my Laptop machine that are likely to never change. Includes i3 configuration, Thinkpad keybindings, battery optimizations, wifi, more dotfiles and package configuration.

### Workstation-Laptop-Chevy.org
###### Inherits from `Laptop` _(Coming soon!)_
2021 Thinkpad x1 Nano on order.

### Workstation-Desktop-Felix.org
###### Inherits from `Desktop`
Felix is my Desktop computer sitting in my office at home. This file contains a lightweight Operating System definition and an extensive Guix Home definition, as well as some associated dotfiles, initialization scripts, etc. I don't store anything meaningful in my Home directory (it's all kept in /data), so this script manages 100% of my it.

### Emacs.org
###### Editor Configuration
Emacs is my editor and primary interface for using my computer day-to-day. This config is large, also defined in literate style, but does not get built beforehand like the rest of this repo. Changes are still deployed via the Guix Store but it is interpreted as Elisp at runtime.

### Get in touch
- Feedback or questions? Find me on [Twitter](https://twitter.com/dustinhlyons).
