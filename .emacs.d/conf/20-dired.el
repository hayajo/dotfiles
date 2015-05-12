(require 'wdired)
(setq wdired-allow-to-change-permissions t)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map "a" 'dired-advertised-find-file)
(defadvice dired-up-directory (around dired-up-directory* (arg) activate)
  "In dired, run `dired-up-directory' and kill previous buffer."
  (let ((buf (current-buffer)))
    ad-do-it
    (if (and (derived-mode-p 'dired-mode)     ; in dired-mode
             (null arg)                       ; no dired-other-window
             (not (eq (current-buffer) buf))) ; unless in the root directory
        (kill-buffer buf))))
