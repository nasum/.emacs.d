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
