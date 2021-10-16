# Makefile, tangles all configs and builds a new guix generation
# Dustin Lyons

SHELL = /bin/sh
CYAN_TERMINAL_OUTPUT = \033[1;36m
GREEN_TERMINAL_OUTPUT = \033[1;32m
RED_TERMINAL_OUTPUT = \033[1;31m
CLEAR = \033[0m

## Config Targets - Tangle literate config into real conf and shell files
## =============================================================================
.ONESHELL:
--config-felix: --config-desktop
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Building Felix...${CLEAR}"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation-Desktop-Felix.org")'
	}

.ONESHELL:
--config-desktop: --config-workstation
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Building Desktop Workstation...${CLEAR}"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation-Desktop.org")'
	}

.ONESHELL:
--config-workstation: --config-emacs
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Building Base Workstation...${CLEAR}"
		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Workstation.org")'
	}

.ONESHELL:
--config-emacs:
	@{ \
		mkdir -p ./build/emacs
		cp Emacs.org ./build/emacs/config.org && \
			echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Copied Emacs.org in preparation for Guix Home daemon...${CLEAR}"
	}


## Deployment Targets - runs guix reconfigure to install new OS generation
## =============================================================================
.ONESHELL:
--deploy-felix-system:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Deploying Guix System...${CLEAR}"
		if sudo -E guix system --cores=12 --load-path=./build reconfigure ./build/felix-os.scm; then
			echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished deploying Guix System.${CLEAR}"
		fi
	}

.ONESHELL:
--deploy-felix-home:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> Deploying Guix Home...${CLEAR}"
		if guix home --load-path=./build reconfigure ./build/felix-home.scm; then
			 echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished deploying Guix Home.${CLEAR}"
		fi
	}

## Activation & Initalize Targets - shell scripts, etc.
## =============================================================================
.ONESHELL:
--activate-felix:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Activating Guix Home...${CLEAR}"
		./build/scripts/activate-workstation.sh && \
			./build/scripts/activate-desktop.sh && \
				./build/scripts/activate-felix.sh && \
					echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished activating Guix Home.${CLEAR}"
	}

.ONESHELL:
--initalize-felix:
	@{ \
		echo -e "${GREEN_TERMINAL_OUTPUT}--> Initializing Guix System...${CLEAR}"
		./build/scripts/initialize-workstation.sh && \
			./build/scripts/initialize-desktop.sh && \
				./build/scripts/initialize-felix.sh && \
					echo -e "${CYAN_TERMINAL_OUTPUT}--> [Makefile] Successfully initialized Guix System. Hooray!${CLEAR}"
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
		echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> [Makefile] Installing Guix System...${CLEAR}"
		if sudo -E guix system --cores=12 --dry-run --load-path=./build reconfigure ./build/felix-os.scm; then
			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished installing Guix System. Hooray!${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} x [Makefile] Failed to install Guix System.${CLEAR}"
		fi
	}

.ONESHELL:
--install-felix-home: --deploy-felix-home --activate-felix
		@echo -e "${CYAN_TERMINAL_OUTPUT}--> [Makefile] Finished installing Guix Home. Hooray!${CLEAR}"

.ONESHELL:
--install-felix-home-dry-run:
	@{ \
		echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} Installing Guix System Home...${CLEAR}"
		if guix home --dry-run --load-path=./build reconfigure ./build/felix-home.scm; then
			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished installing Guix Home.${CLEAR}"
		else
			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} x [Makefile] Failed to install Guix Home.${CLEAR}"
		fi
	}

clean: 
	@echo "Removing build artifacts..."
	@rm -rf build
