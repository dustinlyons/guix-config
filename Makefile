# Makefile, tangles all configs and builds a new guix generation
# Dustin Lyons

SHELL = /bin/sh
GREEN_TERMINAL_OUTPUT = \033[1;32m
RED_TERMINAL_OUTPUT = \033[1;31m
CLEAR = \033[0m

--config-felix: --config-desktop
	@echo "Building System - Desktop - Felix..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "System-Desktop-Felix.org")'

--config-desktop: --config-workstation
	@echo "Building System - Desktop..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "System-Desktop.org")'

--config-workstation: --config-emacs
	@echo "Building System..."
	@emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "System.org")'

.ONESHELL:
--config-emacs:
	@{ \
		cp Emacs.org ./build/emacs/config.org && echo -e "${GREEN_TERMINAL_OUTPUT}--> Copied Emacs.org in preparation for Guix Home daemon...${CLEAR}"
	}

.ONESHELL:
--install-felix:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix System generation...${CLEAR}"
		if sudo -E guix system --load-path=./build reconfigure ./build/felix-os.scm; then
			./build/scripts/activate-system.sh && echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing new Guix System.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix System generation.${CLEAR}"
		fi
	}

.ONESHELL:
--install-felix-slow:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix System generation...${CLEAR}"
		if sudo -E guix system --cores=12 --dry-run --load-path=./build reconfigure ./build/felix-os.scm; then
			./build/scripts/activate-system.sh && echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing new Guix System.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix System generation.${CLEAR}"
		fi
	}

.ONESHELL:
--install-felix-dry-run:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix System generation...${CLEAR}"
		if sudo -E guix system --cores=12 --dry-run --load-path=./build reconfigure ./build/felix-os.scm; then
			echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing new Guix System.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix System generation.${CLEAR}"
		fi
	}

.ONESHELL:
--install-felix-home:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix Home generation...${CLEAR}"
		if guix home --load-path=./build reconfigure ./build/felix-home.scm;  then
			./build/scripts/activate-home.sh && echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing new Guix Home.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix Home generation.${CLEAR}"
		fi
	}

.ONESHELL:
--install-felix-home-dry-run:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix System Home generation..."
		if guix home --dry-run --load-path=./build reconfigure ./build/felix-home.scm; then
			echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing new Guix Home.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix Home generation.${CLEAR}"
		fi
	}

.ONESHELL:
initialize:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Initializing Guix System...${CLEAR}"
		./build/scripts/initialize-home.sh && \
			echo -e "${GREEN_TERMINAL_OUTPUT}Finished initializing Guix System.${CLEAR}"
	}

clean: 
	@echo "Removing build artifacts..."
	@rm -rf build

install-home: --install-felix-home
install-system: --install-felix
install: install-system install-home
