(define-module (felix-home)
  #:use-module (gnu home)
  #:use-module (desktop)
  #:use-module (dl utils)
  #:use-module (gnu home-services)
  #:use-module (gnu home-services shells)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:use-module (guix build utils)
  #:use-module (gnu packages admin)
  #:use-module (guix gexp))

;; Returns a list of home-file-service structs for each dotfile
(define (dl/generate-dotfiles-services dotfiles)
  (if (null? dotfiles)
    '()
  (let ((config-file (string-append "config/" (car dotfiles)))
        (build-file (string-append "build/" (car dotfiles))))
    (cons
      (simple-service 'load-build-files
        home-files-service-type
          (list ;; pair of destination path and source path
            `(,config-file
            ,(local-file build-file "config"))))
      (dl/generate-dotfiles-services (cdr dotfiles))))))

(home-environment
  (packages (map specification->package+output %dl-packages))
  (services (append (list

(simple-service 'felix-environment-variables
		home-environment-variables-service-type
		`(("LANG" . "en_US.UTF-8")
		("LIBGL_ALWAYS_INDIRECT" . #t)
		("HYPHEN_INSENSITIVE" . #t)
		("COMPLETION_WAITING_DOTS" . #t)
		("OSH" . "$HOME/Resources/code/oh-my-bash")
		("GUIX_PROFILE" . "$HOME/.guix-profile")
		("OSH_THEME" . "agnoster")))

(service home-bash-service-type
        (home-bash-configuration
          (guix-defaults? #f)
          (bashrc '("# Export 'SHELL' to child processes.  
# Programs such as 'screen' honor it and otherwise use /bin/sh.
export SHELL
alias ls='ls --color'
    
# We are being invoked from a non-interactive shell.  If this
# is an SSH session (as in \"ssh host command\"), source
# /etc/profile so we get PATH and other essential variables.
if [[ $- != *i* ]]
then
[[ -n \"$SSH_CLIENT\" ]] && source \"$GUIX_PROFILE/etc/profile\"
    
# Don't do anything else.
return
fi

# System wide configuration
source /etc/bashrc

# oh-my-BASH!
export OSH=$HOME/Resources/code/oh-my-bash
source $OSH/oh-my-bash.sh")))))

;; Generates home-files-services for each dotfile defined
;; throughout configuration inheritance
(dl/generate-dotfiles-services
  (append '(".Xmodmap") %dl-dotfiles)))))
