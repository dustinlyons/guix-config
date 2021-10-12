(define-module (felix-os)
  #:use-module (desktop)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu packages))

(operating-system
 (inherit desktop-operating-system)
 (host-name "felix"))
