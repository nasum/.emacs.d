;; 設定ファイルと設定の場所をこのinit.el起点にする
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; add load path
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

;; カスタムファイルを別ファイルにする
(setq custom-file (locate-user-emacs-file "custom.el"))
;; カスタムファイルがない場合は作成する
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
;; カスタムファイルを読み込む
(load custom-file)

;; el-get
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;leaf
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))


;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; モード設定
;; ターミナル以外はツールバー、スクロールバーを非表示にする
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
;; カラム番号を表示
(column-number-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; 時計を表示
(setq display-time-interval 1)
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '((format "%s/%s/%s(%s) %s:%s:%s" year month day dayname 24-hours minutes seconds)))
(display-time-mode t)


;;タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;;行番号を常に表示する
(global-linum-mode t)

;;TABの表示幅を常に4にする
(setq-default tab-width 4)

;;インデントにタブ文字を使用しない
(setq-default indent-tabs-mode nil)

;;現在行のハイライト
(defface my-hl-line-face
  '((((class color) (background dark))
	 (:background "NabyBlue" t))
	(((class color) (background light))
	 (:background "LightSkyBlue" t))
	(t(:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;;対応する括弧を強調して表示する
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match nil)
(set-face-underline-p 'show-paren-match "darkgreen")

;;更新されたファイルを自動的に読み込み直す
(global-auto-revert-mode t)

(provide 'init)

;;packages

(leaf tarao/el-get-lock
  :el-get t
  )
(leaf domtronn/all-the-icons.el
  :el-get t
  )
(leaf memoize
  :el-get t
  )
(leaf bbatsov/projectile
  :el-get t
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  )
(leaf neotree
  :el-get t
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
  :el-get t
  :init
  (leaf *ivy-requirements
    :config
    (leaf swiper
      :ensure t
      :bind (([remap isearch-forward] . swiper)))
    (leaf counsel
      :el-get t
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

(el-get-lock)
(el-get-lock-unlock 'el-get-lock)
