(define-module (dl workstation)
  #:export (%dl-packages-workstation)
  #:export (%dl-dotfiles-workstation))

(define %dl-packages-workstation
  (list
  "picom""font-hack"
  "font-awesome"
  "font-google-roboto"
  "font-google-material-design-icons""polybar""thunar""dunst""brlaser"
  "system-config-printer""alacritty""emacs"
  ))

(define %dl-dotfiles-workstation
  (list
  "picom/picom.conf"".Xresources""polybar/colors.ini"
  "polybar/bars.ini"
  "polybar/modules.ini"
  "polybar/config.ini""Thunar/uca.xml""dunst/dunstrc""printers/printers.conf""alacritty/alacritty.yml""emacs/zeroed-theme.el"
  ))
