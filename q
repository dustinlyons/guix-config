[1mdiff --git a/Computer-Desktop-Felix.org b/Computer-Desktop-Felix.org[m
[1mindex cedb3cb..218b60b 100644[m
[1m--- a/Computer-Desktop-Felix.org[m
[1m+++ b/Computer-Desktop-Felix.org[m
[36m@@ -95,6 +95,7 @@[m [mCLEAR='\033[0m'[m
 [m
 #+END_SRC[m
 [m
[32m+[m
 ** Services[m
 [m
 *** Bash[m
[36m@@ -175,6 +176,7 @@[m [mkeycode 66 = Control_L[m
 add control = Control_L Control_R[m
 #+END_SRC[m
 [m
[32m+[m
 ** Home Environment[m
 [m
 The function below takes the various dotfiles manifests I have defined in my literate configuration and maps them to real files managed by guix home.[m
[1mdiff --git a/Computer-Desktop.org b/Computer-Desktop.org[m
[1mindex bc8ced5..8ed44f5 100644[m
[1m--- a/Computer-Desktop.org[m
[1m+++ b/Computer-Desktop.org[m
[36m@@ -236,9 +236,14 @@[m [mOpenbox is great on a big monitor, so it's primarily used on my Desktop. The dot[m
 This runs after openbox is installed for the first time.[m
 [m
 #+BEGIN_SRC sh :noweb-ref initialize-shell-script :noweb-sep ""[m
[31m-echo -e "${GREEN_TERMINAL_OUTPUT}--> [Openbox] Downloading openbox theme...${CLEAR}"[m
[31m-git clone git@github.com:Dovias/Kaunas.git ~/.themes/Kaunas && \[m
[31m-    echo -e "${GREEN_TERMINAL_OUTPUT}--> [Openbox] Download successful.${CLEAR}"[m
[32m+[m[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Openbox] Looking for openbox theme...${CLEAR}"[m
[32m+[m[32mif [[ -d "$HOME/.themes/Kaunas" ]]; then[m[41m [m
[32m+[m[32m    echo -e "${GREEN_TERMINAL_OUTPUT}--> [Openbox] Found Kaunas.${CLEAR}"[m
[32m+[m[32melse[m
[32m+[m[32m    echo -e "${GREEN_TERMINAL_OUTPUT}--> [Openbox] None found. Cloning Kaunas...${CLEAR}"[m
[32m+[m[32m    git clone git@github.com:Dovias/Kaunas.git ~/.themes/Kaunas && \[m[41m [m
[32m+[m[32m        echo -e "${GREEN_TERMINAL_OUTPUT}--> [Openbox] Download successful.${CLEAR}"[m
[32m+[m[32mfi[m
 [m
 #+END_SRC[m
 [m
[36m@@ -287,6 +292,7 @@[m [mpicom --xrender-sync-fence --backend xrender --config="$HOME/.config/picom/picom[m
 [m
 ****** openbox/rc.xml[m
 rc.xml holds the desktop menu, keyboard shortucts, workspaces, window placement, and display settings.[m
[32m+[m
 #+BEGIN_SRC xml :visiblity folded :tangle build/openbox/rc.xml[m
 <?xml version="1.0"?>[m
 <openbox_config xmlns="http://openbox.org/3.4/rc" xmlns:xi="http://www.w3.org/2001/XInclude">[m
[1mdiff --git a/Computer.org b/Computer.org[m
[1mindex 5ed89ef..1fb705a 100644[m
[1m--- a/Computer.org[m
[1m+++ b/Computer.org[m
[36m@@ -152,6 +152,7 @@[m [mInitialize our bash script that runs as part of each first install.[m
 [m
 #+BEGIN_SRC sh :noweb-ref initialize-shell-script :noweb-sep ""[m
 # This script created from Computer.org[m
[32m+[m[32mWORKING_DIR=$(dirname $(readlink -f $0))[m
 GREEN_TERMINAL_OUTPUT='\033[1;32m'[m
 CLEAR='\033[0m'[m
 [m
[36m@@ -176,8 +177,8 @@[m [mI define small groups of packages in manifest files that enable me to build up t[m
 mkdir -p ~/bin[m
 [m
 # activate-profiles and update-profiles, scripts for Guix profiles[m
[31m-mv build/scripts/activate-profiles ~/bin/activate-profiles[m
[31m-mv build/scripts/update-profiles ~/bin/update-profiles[m
[32m+[m[32mmv $WORKING_DIR/activate-profiles ~/bin/activate-profiles[m
[32m+[m[32mmv $WORKING_DIR/update-profiles ~/bin/update-profiles[m
 chmod +x ~/bin/activate-profiles[m
 chmod +x ~/bin/update-profiles[m
 [m
[36m@@ -187,7 +188,7 @@[m [mchmod +x ~/bin/update-profiles[m
 ***** activate-profiles[m
 [m
 #+NAME: activate-profiles-script[m
[31m-#+BEGIN_SRC scheme :tangle build/scripts/activate-profiles[m
[32m+[m[32m#+BEGIN_SRC sh :tangle build/scripts/activate-profiles[m
 #!/bin/sh[m
 [m
 GREEN='\033[1;32m'[m
[36m@@ -1341,7 +1342,7 @@[m [mThis runs after brlaser is installed for the first time.[m
 # Link configuration and theme at final location[m
 echo -e "${GREEN_TERMINAL_OUTPUT}--> [Polybar] Linking printers.conf...${CLEAR}"[m
 sudo -E ln -fs ~/.config/printers/printers.conf /etc/cups/printers.conf && \[m
[31m-    echo -e "${GREEN_TERMINAL_OUTPUT}--> [Polybar] Linked printers.conf.${CLEAR}"[m
[32m+[m[32m    echo -e "${GREEN_TERMINAL_OUTPUT}--> [Polybar] Linked.${CLEAR}"[m
 [m
 #+END_SRC[m
 [m
[36m@@ -1529,8 +1530,10 @@[m [mThis runs after vim is installed for the first time.[m
 [m
 #+BEGIN_SRC sh :noweb-ref initialize-shell-script :noweb-sep ""[m
 # Download our Vim plugin manager of choice, Plug.vim[m
[32m+[m[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Vim] Downloading plug.vim...${CLEAR}"[m
 curl -fLo ~/.vim/autoload/plug.vim --create-dirs \[m
[31m-  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim[m
[32m+[m[32m  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \[m
[32m+[m[32m    echo -e "${GREEN_TERMINAL_OUTPUT}--> [Vim] Completed.${CLEAR}"[m
 [m
 #+END_SRC[m
 [m
[1mdiff --git a/Makefile b/Makefile[m
[1mindex b8c2898..f30990b 100644[m
[1m--- a/Makefile[m
[1m+++ b/Makefile[m
[36m@@ -2,6 +2,7 @@[m
 # Dustin Lyons[m
 [m
 SHELL = /bin/sh[m
[32m+[m[32mBOLD_TERMINAL_OUTPUT = \e[1;4m[m
 GREEN_TERMINAL_OUTPUT = \033[1;32m[m
 RED_TERMINAL_OUTPUT = \033[1;31m[m
 CLEAR = \033[0m[m
[36m@@ -12,21 +13,21 @@[m [mCLEAR = \033[0m[m
 .ONESHELL:[m
 --config-felix: --config-desktop[m
 	@{ \[m
[31m-		echo -e "${GREEN_TERMINAL_OUTPUT}Building Felix...${CLEAR}"[m
[32m+[m		[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Building Felix...${CLEAR}"[m
 		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Computer-Desktop-Felix.org")'[m
 	}[m
 [m
 .ONESHELL:[m
 --config-desktop: --config-computer[m
 	@{ \[m
[31m-		echo -e "${GREEN_TERMINAL_OUTPUT}Building Desktop Computer...${CLEAR}"[m
[32m+[m		[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Building Desktop Computer...${CLEAR}"[m
 		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Computer-Desktop.org")'[m
 	}[m
 [m
 .ONESHELL:[m
 --config-computer: --config-emacs[m
 	@{ \[m
[31m-		echo -e "${GREEN_TERMINAL_OUTPUT}Building Base Computer...${CLEAR}"[m
[32m+[m		[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Building Base Computer...${CLEAR}"[m
 		emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "Computer.org")'[m
 	}[m
 [m
[36m@@ -35,7 +36,7 @@[m [mCLEAR = \033[0m[m
 	@{ \[m
 		mkdir -p ./build/emacs[m
 		cp Emacs.org ./build/emacs/config.org && \[m
[31m-			echo -e "${GREEN_TERMINAL_OUTPUT}--> Copied Emacs.org in preparation for Guix Home daemon...${CLEAR}"[m
[32m+[m			[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Copied Emacs.org in preparation for Guix Home daemon...${CLEAR}"[m
 	}[m
 [m
 [m
[36m@@ -44,9 +45,9 @@[m [mCLEAR = \033[0m[m
 .ONESHELL:[m
 --deploy-felix-system:[m
 	@{ \[m
[31m-		echo -e "${GREEN_TERMINAL_OUTPUT}--> Deploying Guix System...${CLEAR}"[m
[32m+[m		[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Deploying Guix System...${CLEAR}"[m
 		if sudo -E guix system --cores=12 --load-path=./build reconfigure ./build/felix-os.scm; then[m
[31m-			echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished deploying Guix System.${CLEAR}"[m
[32m+[m			[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished deploying Guix System.${CLEAR}"[m
 		fi[m
 	}[m
 [m
[36m@@ -55,7 +56,7 @@[m [mCLEAR = \033[0m[m
 	@{ \[m
 		echo -e "${GREEN_TERMINAL_OUTPUT}--> Deploying Guix Home...${CLEAR}"[m
 		if guix home --load-path=./build reconfigure ./build/felix-home.scm; then[m
[31m-			 echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished deploying Guix Home.${CLEAR}"[m
[32m+[m			[32m echo -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished deploying Guix Home.${CLEAR}"[m
 		fi[m
 	}[m
 [m
[36m@@ -64,11 +65,11 @@[m [mCLEAR = \033[0m[m
 .ONESHELL:[m
 --activate-felix:[m
 	@{ \[m
[31m-		echo -e "${GREEN_TERMINAL_OUTPUT}--> Activating Guix System...${CLEAR}"[m
[32m+[m		[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Activating Guix System...${CLEAR}"[m
 		./build/scripts/activate-computer.sh && \[m
 			./build/scripts/activate-desktop.sh && \[m
 				./build/scripts/activate-felix.sh && \[m
[31m-					echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished activating Guix System.${CLEAR}"[m
[32m+[m					[32mecho -e "${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished activating Guix System.${CLEAR}"[m
 	}[m
 [m
 .ONESHELL:[m
[36m@@ -78,7 +79,7 @@[m [mCLEAR = \033[0m[m
 		./build/scripts/initialize-computer.sh && \[m
 			./build/scripts/initialize-desktop.sh && \[m
 				./build/scripts/initialize-felix.sh && \[m
[31m-					echo -e "${GREEN_TERMINAL_OUTPUT}--> Successfully initialized Guix System.${CLEAR}"[m
[32m+[m					[32mecho -e "${BOLD_TERMINAL_OUTPUT}--> [Makefile] Successfully initialized Guix System. Hooray!${CLEAR}"[m
 	}[m
 [m
 ## Install Targets - Dry run targets, or the real deal[m
[36m@@ -93,25 +94,26 @@[m [minstall-system: --install-felix[m
 .ONESHELL:[m
 --install-felix-dry-run:[m
 	@{ \[m
[31m-		echo -e "${GREEN_TERMINAL_OUTPUT}Installing Guix System...${CLEAR}"[m
[32m+[m		[32mecho -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> [Makefile] Installing Guix System...${CLEAR}"[m
 		if sudo -E guix system --cores=12 --dry-run --load-path=./build reconfigure ./build/felix-os.scm; then[m
[31m-			echo -e "${GREEN_TERMINAL_OUTPUT}--> Finished installing Guix System.${CLEAR}"[m
[32m+[m			[32mecho -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished installing Guix System. Hooray!${CLEAR}"[m
 		else[m
[31m-			echo -e "${RED_TERMINAL_OUTPUT}x Failed to install Guix System.${CLEAR}"[m
[32m+[m			[32mecho -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} x [Makefile] Failed to install Guix System.${CLEAR}"[m
 		fi[m
 	}[m
 [m
 .ONESHELL:[m
 --install-felix-home: --deploy-felix-home --activate-felix[m
[32m+[m		[32m@echo -e "${BOLD_TERMINAL_OUTPUT}--> [Makefile] Finished installing Guix Home. Hooray!${CLEAR}"[m
 [m
 .ONESHELL:[m
 --install-felix-home-dry-run:[m
 	@{ \[m
[31m-		echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} Installing Guix System Home..."[m
[32m+[m		[32mecho -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} Installing Guix System Home...${CLEAR}"[m
 		if guix home --dry-run --load-path=./build reconfigure ./build/felix-home.scm; then[m
[31m-			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> Finished installing Guix Home."[m
[32m+[m			[32mecho -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT}--> [Makefile] Finished installing Guix Home.${CLEAR}"[m
 		else[m
[31m-			echo -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} x Failed to install Guix Home."[m
[32m+[m			[32mecho -e "${RED_TERMINAL_OUTPUT}[DRY RUN]${CLEAR}${GREEN_TERMINAL_OUTPUT} x [Makefile] Failed to install Guix Home.${CLEAR}"[m
 		fi[m
 	}[m
 [m
