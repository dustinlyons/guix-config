(define-module (felix-home)
  #:use-module (gnu home)
  #:use-module (desktop)
  #:use-module (dl utils)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu )
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:use-module (guix build utils)
  #:use-module (gnu packages admin)
  #:use-module (guix gexp))

;; Returns a list of home-file-service structs for each dotfile
(define (generate-dotfiles-services dotfiles)
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
      (generate-dotfiles-services (cdr dotfiles))))))

(home-environment
  (packages (map specification->package+output %dl-packages))
  (services
    (append (list
      (service home-bash-service-type
        (home-bash-configuration
          (guix-defaults? #t)
          (bashrc (list
            (local-file "bash/bashrc.sh"))))))
      (generate-dotfiles-services %dl-dotfiles))))
