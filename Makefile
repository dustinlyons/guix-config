# Makefile, tangles all configs and builds a new guix generation
# Dustin Lyons

SHELL = /bin/sh

--config-felix: --config-desktop
	@echo "Building Workstation - Desktop - Felix..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation-Desktop-Felix.org")'

--config-desktop: --config-workstation
	@echo "Building Workstation - Desktop..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation-Desktop.org")'

--config-workstation:
	@echo "Building Workstation..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation.org")'

--install-felix:
	@echo "Installing new guix system generation..."
	sudo -E guix system --load-path=./build reconfigure ./build/felix-os.scm

--install-felix-slow:
	@echo "Installing new guix system generation..."
	sudo -E guix system --load-path=./build --cores=12 reconfigure ./build/felix-os.scm

--install-felix-dry-run:
	@echo "Installing new guix system generation..."
	sudo -E guix system --cores=12 --dry-run --load-path=./build reconfigure ./build/felix-os.scm

--install-felix-home:
	@echo "Installing new guix home generation..."
	guix home --dry-run --load-path=./build reconfigure ./build/felix-home.scm

--install-felix-home-dry-run:
	@echo "Installing new guix home generation..."
	guix home --dry-run --load-path=./build reconfigure ./build/felix-home.scm

clean: 
	@echo "Removing build artifacts..."
	@rm -rf build

install-home: --install-felix-home-dry-run
install-system: --install-felix-dry-run
install: install-system install-home
