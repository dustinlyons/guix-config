# Makefile 
# Tangles all configs and builds a new guix generation
SHELL = /bin/sh

config-felix: config-desktop
	@echo "Building Workstation - Desktop - Felix..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation-Desktop-Felix.org")'

config-workstation:
	@echo "Building Workstation..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation.org")'

config-desktop: config-workstation
	@echo "Building Workstation - Desktop..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation-Desktop.org")'

install:
	@echo "Installing new guix generation..."
	sudo -E guix system -L ./build/guix reconfigure ./build/guix/desktop.scm

clean: 
	@echo "Removing build artifacts..."
	@rm -rf build
