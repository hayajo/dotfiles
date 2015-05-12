(req flybmake
     (add-hook 'find-file-hook 'flymake-find-file-hook))

(global-set-key (kbd "M-p") 'flymake-goto-prev-error)
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
