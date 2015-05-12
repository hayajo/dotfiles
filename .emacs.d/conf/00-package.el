(when (require 'package nil t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))

(defun package-auto-install (list)
  ""
  (when (require 'package nil t)
    (let ((contents-refreshed nil))
      (while list
        (let ((package-name (car list)))
          (if (not (assoc package-name package-alist))
              (progn
                (if (not contents-refreshed)
                    (progn
                      (package-refresh-contents)
                      (setq contents-refreshed t)))
                (package-install package-name)
                (package-initialize))))
        (setq list (cdr list))))))

(package-auto-install
 '(
   auto-complete
   bm
   cperl-mode
   egg
   flymake
   inf-ruby
   multi-term
   php-mode
   ruby-block
   ruby-electric
   session
   wgrep
   zencoding-mode
   yaml-mode
   ))
