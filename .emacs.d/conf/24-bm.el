(req bm
     (setq-default bm-buffer-persistence t)
     (add-hook 'after-init-hook 'bm-repository-load)
     (add-hook 'find-file-hooks 'bm-buffer-restore)
     (add-hook 'kill-buffer-hook 'bm-buffer-save)
     (add-hook 'after-save-hook 'bm-buffer-save)
     (add-hook 'after-revert-hook 'bm-buffer-restore)
     (add-hook 'vc-before-checkin-hook 'bm-buffer-save)
     (add-hook 'kill-emacs-hook '(lambda nil
                                   (bm-buffer-save-all)
                                   (bm-repository-save)))
     (global-set-key (kbd "C-c @") 'bm-toggle)
     (global-set-key (kbd "C-c [") 'bm-previous)
     (global-set-key (kbd "C-c ]") 'bm-next))
