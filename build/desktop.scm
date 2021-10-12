(define-module (desktop)
  #:use-module (workstation)
  #:use-module (srfi srfi-1) ;; for the remove function
  #:use-module (guix transformations)
  #:use-module (guix channels)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages linux)
  #:use-module (gnu services cups)
  #:use-module (gnu packages cups)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services linux)
  #:use-module (gnu services desktop)
  #:use-module (nongnu packages nvidia)
  #:use-module (dl utils) ;; for the dotfiles functions
  #:use-module (gnu))

(define transform
  (options->transformation
    '((with-graft . "mesa=nvda"))))

(define-public desktop-operating-system
 (operating-system
   (inherit base-operating-system)
   (host-name "desktop")

(kernel-arguments
  (append
    '("modprobe.blacklist=nouveau") ;; Use nvidia-driver instead 
    %default-kernel-arguments))

(kernel-loadable-modules (list nvidia-driver))

;; Allow resolution of '.local' host names with mDNS
(name-service-switch %mdns-host-lookup-nss)

;; File partitions, filesystems
(file-systems
  (cons* (file-system ;; One big fat btrfs partition for our stuff
           (mount-point "/")
           (device (uuid "3fdd9ded-2779-4401-8b3f-b5a9179a5a6f" 'btrfs))
           (type "btrfs"))

(file-system ;; UEFI boot partition
  (mount-point "/boot/efi")
  (device (uuid "1F00-ED40" 'fat32))
  (type "vfat"))
%base-file-systems))

;; @todo: Move to guix-home, move packages to profile manifests
;; Users, home directories, groups, etc.
(users (cons* (user-account
                (name "dustin") ;; It me
                (comment "Dustin")
                (group "users")
                (home-directory "/home/dustin")
                (supplementary-groups
                  '("wheel" "netdev" "audio" "video" "lp")))
              %base-user-accounts))

;; Install a base set of Desktop packages
;; @todo: Decide what to do with these packages
(packages (append (map specification->package 
	      '("openbox" "htop" "git" "gnupg" "nss-certs" "vim" "emacs" "firefox" "xf86-input-libinput" "gvfs")) %base-packages))

(services (cons* (service special-files-service-type
 `(("/bin/sh" ,(file-append bash "/bin/bash"))
   ("/bin/bash" ,(file-append bash "/bin/bash"))
   ("/usr/bin/env" ,(file-append coreutils "/bin/env"))))

   (simple-service 'custom-udev-rules udev-service-type 
     (list nvidia-driver))

   (service kernel-module-loader-service-type
    '("ipmi_devintf"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"))

   (service cups-service-type
     (cups-configuration
       (web-interface? #t)
       (extensions
         (list cups-filters brlaser))))

   (service slim-service-type (slim-configuration
     (display ":0")
     (vt "vt8")
     (xorg-configuration (xorg-configuration
       (keyboard-layout (keyboard-layout "us"
         #:options '("ctrl:nocaps")))
        (modules (cons* nvidia-driver %default-xorg-modules))
          (server (transform xorg-server))
          (drivers '("nvidia"))))))

   (remove (lambda (service)
     (eq? (service-kind service) gdm-service-type))
	%desktop-services)))))
