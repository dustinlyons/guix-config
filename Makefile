# Makefile, tangles all configs and builds a new guix generation
# Dustin Lyons

SHELL = /bin/sh
GREEN_TERMINAL_OUTPUT = \033[1;32m
RED_TERMINAL_OUTPUT = \033[1;31m
CLEAR = \033[0m


## Config Targets - Tangle literate config into real conf and shell files
## =============================================================================
.ONESHELL:
--config-felix: --config-desktop
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Building Felix...${CLEAR}"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Computer-Desktop-Felix.org")'
	}

.ONESHELL:
--config-desktop: --config-computer
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Building Desktop Computer...${CLEAR}"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Computer-Desktop.org")'
	}

.ONESHELL:
--config-computer: --config-emacs
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Building Base Computer...${CLEAR}"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Computer.org")'
	}

.ONESHELL:
--config-emacs:
	@{ \
		mkdir -p ./build/emacs
		cp Emacs.org ./build/emacs/config.org && \
			echo -e "${GREEN_TERMINAL_OUTPUT}--> Copied Emacs.org in preparation for Guix Home daemon...${CLEAR}"
	}


## Deployment Targets - runs guix reconfigure to install new OS generation
## =============================================================================
.ONESHELL:
--deploy-felix-system:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> Deploying Guix System...${CLEAR}"
		if sudo -E guix system --cores=12 --load-path=./build reconfigure ./build/felix-os.scm; then
			echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished deploying Guix System.${CLEAR}"
		fi
	}

.ONESHELL:
--deploy-felix-home:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> Deploying Guix Home...${CLEAR}"
		if guix home --load-path=./build reconfigure ./build/felix-home.scm; then
			 echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished deploying Guix Home.${CLEAR}"
		fi
	}

## Activation & Initalize Targets - shell scripts, etc.
## =============================================================================
.ONESHELL:
--activate-felix:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> Activating Guix System...${CLEAR}"
		./build/scripts/activate-computer.sh && \
			./build/scripts/activate-desktop.sh && \
				./build/scripts/activate-felix.sh && \
					echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished activating Guix System.${CLEAR}"
	}

.ONESHELL:
--initalize-felix:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> Initializing Guix System...${CLEAR}"
		./build/scripts/initialize-computer.sh && \
			./build/scripts/initialize-desktop.sh && \
				./build/scripts/initialize-felix.sh && \
					echo -e "${GREEN_TERMINAL_OUTPUT}--> Successfully initialized Guix System.${CLEAR}"
	}

## Install Targets - Dry run targets, or the real deal
## =============================================================================

install: install-system install-home
install-home: --install-felix-home
install-system: --install-felix

--install-felix: --deploy-felix --activate-felix

.ONESHELL:
--install-felix-dry-run:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix System...${CLEAR}"
		if sudo -E guix system --cores=12 --dry-run --load-path=./build reconfigure ./build/felix-os.scm; then
			echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing Guix System.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix System.${CLEAR}"
		fi
	}

.ONESHELL:
--install-felix-home: --deploy-felix-home --activate-felix

.ONESHELL:
--install-felix-home-dry-run:
	@{ \
		echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} Installing Guix System Home..."
		if guix home --dry-run --load-path=./build reconfigure ./build/felix-home.scm; then
			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> Finished installing Guix Home."
		else
			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} x Failed to install Guix Home."
		fi
	}

## Misc Targets - Helpful make targets go here
## =============================================================================
clean: 
	@echo "Removing build artifacts..."
	@rm -rf build
