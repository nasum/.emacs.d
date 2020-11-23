(leaf ruby-mode
  :mode
  (("\\Capfile\\'" . ruby-mode)
   ("\\Gemfile\\'" . ruby-mode)
   ("\\[Rr]akefile\\'" . ruby-mode)
   ("\\.rb\\'" . ruby-mode)
   ("\\.ru\\'" . ruby-mode)
   ("\\.rake\\'" . ruby-mode)
   ("\\.feature\\'" . ruby-mode)
   ("\\.jbuilder\\'" . ruby-mode))
  :hook
  (
   (ruby-mode . lsp-deffer)
  )
  )
