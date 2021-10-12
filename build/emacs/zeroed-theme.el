(require 'autothemer)

(autothemer-deftheme
  zeroed "A theme for my lab."

  ;; Specify terminal types
  ((((class color) (min-colors #xFFFFFF)) 
    ((class color) (min-colors #xFF)))

   ;; Define color palette
   (zeroed-red "#EC5F67")
   (zeroed-green "#99C794")
   (zeroed-yellow "#FFC247")
   (zeroed-orange "#FA9850")
   (zeroed-blue "#6699CC")
   (zeroed-purple "#C594C5")
   (zeroed-cyan "#5FB3B3")
   (zeroed-light-grey "#C0C5CE")
   (zeroed-dark-grey "#1F2528")
   (zeroed-dark-grey-2 "#1A1F21")
   (zeroed-greyed-out "#2F393D")
   (zeroed-white "#FFFFFF"))

    ;; Face specifications
   ((default (:foreground zeroed-light-grey :background zeroed-dark-grey))
    (cursor (:background zeroed-light-grey)) ;; Block cursor color
    (mode-line (:background zeroed-dark-grey-2)) ;; Block cursor color
    (region (:background zeroed-dark-grey-2)) ;; Selection box
    (font-lock-keyword-face (:foreground zeroed-blue))
    (font-lock-comment-face (:foreground zeroed-orange))
    (font-lock-comment-delimiter-face (:foreground zeroed-orange))
    (link (:foreground zeroed-blue :weight 'bold :underline t))
    (org-block (:foreground zeroed-light-grey :background zeroed-dark-grey-2))
    (org-block-begin-line (:foreground zeroed-light-grey :background zeroed-purple))
    (org-block-end-line (:foreground zeroed-light-grey :background zeroed-purple))
    (org-document-info-keyword (:foreground zeroed-green :weight 'bold))
    (org-document-title (:foreground zeroed-green :weight 'bold))
    (org-level-1 (:foreground zeroed-cyan))
    (org-level-2 (:foreground zeroed-yellow))
    (org-level-3 (:foreground zeroed-blue))
    (org-level-4 (:foreground zeroed-orange))
    (doom-modeline-buffer-modified (:foreground zeroed-red :weight 'bold))
    (org-meta-line (:foreground zeroed-light-grey :background zeroed-dark-grey))
    (org-headline-done (:foreground zeroed-greyed-out :strike-through t))
    (minibuffer-prompt (:foreground zeroed-cyan))
    (org-drawer (:foreground zeroed-blue))
    (org-special-keyword (:foreground zeroed-blue))
    (org-table (:foreground zeroed-purple)))

    ;; Forms after the face specifications are evaluated
    (custom-theme-set-variables 'zeroed
        `(ansi-color-names-vector [,zeroed-red
                                   ,zeroed-green
                                   ,zeroed-yellow
                                   ,zeroed-purple
                                   ,zeroed-yellow
                                   ,zeroed-orange
                                   ,zeroed-cyan])))
   (provide-theme 'zeroed)
