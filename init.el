;; 設定ファイルと設定の場所をこのinit.el起点にする
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; add load path
(add-to-list 'load-path "./elisp")

;; カスタムファイルを別ファイルにする
(setq custom-file (locate-user-emacs-file "custom.el"))
;; カスタムファイルがない場合は作成する
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
;; カスタムファイルを読み込む
(load custom-file)

;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; モード設定
;; ターミナル以外はツールバー、スクロールバーを非表示にする
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

;; カラム番号を表示
(column-number-mode t)
