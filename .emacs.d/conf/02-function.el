;; 単語の先頭に移動するforward-word
(defun myfun-forward-word (arg)
  (interactive "p")
  (cond
   ((region-active-p) (forward-word arg))
   ((looking-at ".$") (re-search-forward "\\W\\b\\"))
   ((looking-at "\\cj") (forward-word arg))
   ((looking-at "\\(。\\|、\\|．\\|，\\)") (re-search-forward "\[。、．，\]+"))
   (t (re-search-forward "\\(.$\\|\\W\\b\\)"))))
(unless (fboundp 'region-active-p)
  (defun region-active-p ()
    (and transient-mark-mode mark-active)))

;; ジャンクファイルを作成
(defun myfun-open-junk-file (basedir &optional ext)
  (interactive)
  (let* ((file (expand-file-name
                (concat (format-time-string
                         "%Y/%m/%Y-%m-%d-%H%M%S." (current-time))
                        ext)
                basedir))
         (dir (file-name-directory file)))
    (make-directory dir t)
    (find-file (read-file-name "Junk Code: " file file))))

;; *scratch* バッファを作成
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
;; *scratch* バッファで kill-buffer しても *scratch* バッファを残す
(add-hook-fn 'kill-buffer-query-functions
             (if (string= "*scratch*" (buffer-name))
                 (progn (my-make-scratch 0) nil)
               t))
;; *scratch* バッファの内容を（名前をつけて）保存した場合は *scratch* バッファを新しく作る
(add-hook-fn 'after-save-hook
             (unless (member (get-buffer "*scratch*") (buffer-list))
               (my-make-scratch 1)))
