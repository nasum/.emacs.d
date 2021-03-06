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
;;(global-linum-mode t)

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
