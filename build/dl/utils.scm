(define-module (dl utils)
  #:export (%dl-packages)
  #:export (%dl-dotfiles))

  (use-modules (dl workstation)
               (dl desktop))

  (define %dl-packages
    (append %dl-packages-workstation %dl-packages-desktop))

  (define %dl-dotfiles
    (append %dl-dotfiles-workstation %dl-dotfiles-desktop))
