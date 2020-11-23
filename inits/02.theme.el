(leaf doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(leaf doom-modeline
  :init (doom-modeline-mode 1)
)
