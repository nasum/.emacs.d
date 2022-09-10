;; 設定ファイルと設定の場所をこのinit.el起点にする
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; カスタムファイルを別ファイルにする
(setq custom-file (locate-user-emacs-file "custom.el"))
;; カスタムファイルがない場合は作成する
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
;; カスタムファイルを読み込む
(load custom-file)

;; add load path
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

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

;;el-get package
(el-get-bundle tarao/el-get-lock
  (el-get-lock)
  (el-get-lock-unlock 'el-get-lock)
  )
(el-get-bundle init-loader)
(el-get-bundle ivy)
(el-get-bundle abo-abo/swiper)
(el-get-bundle domtronn/all-the-icons.el)
(el-get-bundle memoize)
(el-get-bundle bbatsov/projectile)
(el-get-bundle neotree)
(el-get-bundle abo-abo/hydra)
(el-get-bundle magit)
(el-get-bundle git-gutter)
;; lsp
(el-get-bundle emacs-lsp/lsp-mode)
(el-get-bundle emacs-lsp/lsp-ui)
(el-get-bundle emacs-lsp/lsp-ivy)
(el-get-bundle emacs-lsp/lsp-python-ms)
(el-get-bundle flycheck)
(el-get-bundle company-mode)
(el-get-bundle doom-themes)
(el-get-bundle doom-modeline)

(el-get-lock)
(el-get-lock-unlock 'el-get-lock)


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

(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load (concat user-emacs-directory "inits"))

;; for Mac
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
