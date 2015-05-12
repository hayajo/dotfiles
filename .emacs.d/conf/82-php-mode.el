(req php-mode
     (setq php-search-url "http://jp.php.net/ja/" ;
           php-manual-url "http://jp.php.net/manual/ja/" ;
           php-mode-force-pear t))

(add-hook-fn 'php-mode-hook
             (c-set-style "k&r")
             (setq c-basic-offset 4)
             (c-set-offset 'arglist-intro '+)
             (c-set-offset 'arglist-close '0))
             
             ;; (setq indent-tabs-mode nil)
             ;; (setq c-basic-offset 4)
             ;; (c-set-style "k&r")
             ;; (c-set-offset 'arglist-intro '+)
             ;; (c-set-offset 'arglist-close '0))
