(leaf bbatsov/projectile
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  )

(leaf neotree
  :after projectile
  :bind
  (
   ("M-p f" . projectile--find-file)
   ("M-p F" . projectile-switch-project)
   ("<f8>" . neotree-project-dir)
   )
  :config
  (setq-default neo-show-hidden-files t)
  (setq neo-create-file-auto-open t)
  (setq-default neo-keymap-style 'concise)
  (setq neo-theme 'icons)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq projectile-known-projects-file
      (expand-file-name "projectile-bookmarks.eld" "~/"))
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  :hook
  (neo-after-create .
                    (lambda (&rest _) (display-line-numbers-mode -1)))
  )
(leaf ivy
  :init
  (leaf *ivy-requirements
    :config
    (leaf swiper
      :bind (([remap isearch-forward] . swiper)))
    (leaf counsel
      :diminish counsel-mode
      :bind (
             ([remap isearch-forward] . counsel-imenu)
             ("C-x C-r" . counsel-recentf)
             )
    )
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  )
  )

(leaf magit)
(leaf git-gutter
  :config
  (global-git-gutter-mode t)
  (custom-set-variables
   '(git-gutter:modified-sign "~")
   '(git-gutter:added-sign    "+")
   '(git-gutter:deleted-sign  "-")
   )
  (set-face-background 'git-gutter:modified "#f1fa8c")
  (set-face-foreground 'git-gutter:added "#50fa7b")
  (set-face-foreground 'git-gutter:deleted "#ff79c6")
  )
