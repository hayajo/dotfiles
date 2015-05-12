(setq history-length t)
(req session
     (setq session-initialize '(de-saveplace session keys menus places)
           session-globals-include '((kill-ring 50)
                                     (session-file-alist 500 t)
                                     (file-name-history 10000)))
     (add-hook 'after-init-hook 'session-initialize)
     ;; (setq session-undo-check -1)
     )
