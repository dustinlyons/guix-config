(define-module (dl desktop)
  #:export (%dl-packages-desktop)
  #:export (%dl-dotfiles-desktop))

(define %dl-packages-desktop
  (list
    "openbox""rofi"
  ))

(define %dl-dotfiles-desktop
  (list
    "openbox/autostart"
    "openbox/rc.xml""rofi/launcher.sh"
    "rofi/theme.rasi"
  ))
