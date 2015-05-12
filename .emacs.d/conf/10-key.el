(keyboard-translate ?\C-h ?\C-?) ; C-h を <backspace> に変更

(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-x ?") 'help-command)
(global-set-key (kbd "C-c ;") 'comment-region)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-x C-b") 'bs-show)

;; ref. conf/init-function.el
(global-set-key "\M-f" 'myfun-forward-word)
(global-set-key-fn (kbd "\C-x4j") nil (interactive) (myfun-open-junk-file "~/Documents/junk"))

;; カーソル位置の単語を削除
(global-set-key-fn
 (kbd "M-d")
 nil
 (interactive)
 (let ((char (char-to-string (char-after (point)))))
   (cond
    ((string= " " char) (delete-horizontal-space))
    ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
    (t (forward-char) (backward-word) (kill-word 1)))))

;; M-x で ido を利用
(global-set-key-fn
 (kbd "M-x")
 nil
 (interactive)
 (call-interactively
  (intern
   (ido-completing-read
    "M-x "
    (all-completions "" obarray 'commandp)))))
