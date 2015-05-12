(defalias 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4 ;
      cperl-continued-statement-offset 4 ;
      cperl-brace-offset -4 ;
      cperl-label-offset -4 ;
      cperl-indent-parens-as-block t ;
      cperl-close-paren-offset -4 ;
      cperl-tab-always-indent t ;
      cperl-indent-subs-specially nil ;
      cperl-highlight-variables-indiscriminately t)
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))

(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))
