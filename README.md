# guix-config

## Screenshot

![Desktop in October, 2021](res/Desktop.png) 

## Overview
### What is this?

_tl;dr The "functional programming" equivalent to operating systems_

The configuration of my operating system (GuixSD) and day-to-day software (who are we kidding, emacs) defined in literate configuration style. The .org files represent the code itself. Makefile is used to [tangle](https://orgmode.org/worg/org-contrib/babel/intro.html) the code into seperate files of which are primarily Scheme. Finally, the Guix daemon interprets the files to generate everything from my desktop and laptop, to servers running in a rack or VMs inside of a hypervisor. _(coming soon)_

No more traditional dotfiles. Hello Scheme and literate config.

### Why?

With everything defined in this way I can treat my system as one program without pulling my hair out. It's 100% reproducible.

Every change to my system is now deployed from the [guix store](https://guix.gnu.org/manual/en/html_node/The-Store.html) thanks to [guix home](https://guix.gnu.org/manual/devel/en/html_node/Home-Configuration.html). This means I get rollbacks, transcational upgrades, fine-grained profiles, and other guix goodness with even my dotfiles.

Other advantages: 
- theming now becomes easier. It's all here, I can define one set of colors, fonts, or margins to be used everywhere. Technically possible before but again, don't want to pull my hair out.
- no more "polutting" my system with experiments. I can try different blockchain projects, work with a client that needs .NET, or do anything I want without feeling like I need to clean it up later.
- Scheme is fun to hack on, and I hack on my home-lab for fun

Learn more about guix [here](https://guix.gnu.org/).

### Installation

This project isn't intended for outside use yet; please just use as an example. I use Makefile to tangle org files into their own configs and then ```guix system reconfigure``` to inject those config files into ```.config```, create symlinks, set environment variables, etc. 

##### Generate a ```build``` directory that contains all guix and dotfile configuration

```sh
$ make
```

##### Install new configuration and move system to next generation
```sh
$ make install
```

## Files and Organization

I use inheritance to share configuration amgonst my machines where it makes sense. This is subject to change as I make progress.

## System Level
Base images.

### Workstation
Base definition of machines I'll work on day-to-day. This is to seperate configuration concerns from machines I have running in my home-lab. Those will likely be created in a _`Server`_ namespace eventually.

### Server
Coming soon.

## "Sensible Defaults"
I keep configuration here that I don't see changing anytime soon.

### Desktop
_Inherits from `Workstation`_

Sensible definitions for my Desktop machine that are likely to never change. Also includes some package definitions, but very light. When the inevitable day comes, and my new (3+ month shipping) Thinkpad X1 Nano arrives, this file will delininate configuration change from my Laptop.

### Laptop
_Inherits from `Workstation`_

Coming soon.

## Systems

### Chevy
_Inherits from `Laptop`_

Coming soon.

### Felix
_Inherits from `Desktop`_

Felix is my Desktop computer sitting in my office at home. This is a work in progress. I'm working on using guix-home to build out a new home directory on each system configuration, setup environment variables, sym-links, etc.

### Get in touch
- Feedback or questions? Find me on [Twitter](https://twitter.com/dustinhlyons).
