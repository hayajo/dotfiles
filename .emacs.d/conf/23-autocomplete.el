(req auto-complete-config
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (global-auto-complete-mode t))
