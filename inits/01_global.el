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

;;lsp
(leaf lsp-mode
  :commands lsp
  :custom
  (
   (lsp-inhibit-message . t)
   (lsp-message-project-root-warning . t)
   (lsp-prefer-capf . t)
   (create-lockfiles . nil)
   (lsp-auto-configure . t)
   (lsp-file-watch-threshold . 2000)
   (lsp-prefer-flymake 'flymake)
   )
  :hook
  (python-mode-hook . lsp)
  (ruby-mode-hook . lsp)
  (prog-major-mode . lsp-prog-major-mode-enable)
  )
(leaf lsp-ui
  :commands lsp-ui-mode
  :custom
  (
   ;; lsp-ui-doc
   (lsp-ui-doc-enable . t)
   (lsp-ui-doc-header . t)
   (lsp-ui-doc-include-signature . t)
   (lsp-ui-doc-position . 'at-point)
   (lsp-ui-doc-max-width .  150)
   (lsp-ui-doc-max-height . 30)
   (lsp-ui-doc-use-childframe . t)
   (lsp-ui-doc-use-webkit . nil)
   ;; lsp-ui-flycheck
   (lsp-ui-flycheck-enable . nil)
   ;; lsp-ui-sideline
   (lsp-ui-sideline-enable . t)
   (lsp-ui-sideline-ignore-duplicate . t)
   (lsp-ui-sideline-show-symbol . t)
   (lsp-ui-sideline-show-hover . t)
   (lsp-ui-sideline-show-diagnostics . t)
   (lsp-ui-sideline-show-code-actions . t)
   ;; lsp-ui-imenu
   (lsp-ui-imenu-enable . nil)
   (lsp-ui-imenu-kind-position . 'top)
   ;; lsp-ui-peek
   (lsp-ui-peek-enable . t)
   (lsp-ui-peek-always-show . t)
   (lsp-ui-peek-peek-height . 30)
   (lsp-ui-peek-list-width . 30)
   (lsp-ui-peek-fontify . 'always)
   )
   :bind
   (
    ("M-." . lsp-ui-peek-find-definitions)
    ("M-/" . lsp-ui-peek-find-references)
    ("M-]" . lsp-ui-peek-find-implementation)
    )
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode))
(leaf emacs-lsp/lsp-ivy :commands lsp-ivy-workspace-symbol)
;;company
(leaf company
  :config
  (global-company-mode t)
  )
