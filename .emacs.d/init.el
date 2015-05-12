(when (< emacs-major-version 24)
    (error "this init.el supports emacs 24 or later"))

;;---
(require 'cl)

(cd "~")

;; load-path
(when (> emacs-major-version 23)
 (defvar user-emacs-directory "~/.emacs.d"))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "elisp" "conf" "elpa" "public_repos")

;; init-loader.el
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")
(when (not (string= (init-loader-error-log) ""))
  (init-loader-show-log))

;; private
(load "~/.emacs.el.local" t)
(put 'dired-find-alternate-file 'disabled nil)
