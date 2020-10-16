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

;; ターミナル以外はツールバー、スクロールバーを非表示にする
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
