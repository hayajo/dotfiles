(setq ruby-indent-level 3 ;
      ruby-deep-indent-paren nil)

(require 'ruby-electric nil t)
(req ruby-block
     (setq ruby-block-highlight-toggle t))

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-setup-keybindings "inf-ruby"
          "Set local key defs for inf-ruby in ruby-mode")

;;    (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
;;    (autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t)
;;    (eval-after-load 'ruby-mode
;;      '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))

(defun ruby-mode-hooks ()
  (inf-ruby-setup-keybindings)
  (ruby-electric-mode t)
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
