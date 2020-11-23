(leaf lsp-python-ms
  :init
  (setq lsp-python-ms-auto-install-server t)
  ;; set microsoft python languageserver path
  (setq lsp-python-ms-executable
      "~/src/github.com/Microsoft/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer")
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-python-ms)
                   (lsp)))
)

(leaf python
  :mode ("\\.py" . python-mode)
  :config
  (setq lsp-pyls-plugins-pylint-enabled t)
  (setq lsp-pyls-plugins-pycodestyle-enabled nil)
  )
