;; add-hookを簡潔に
(defmacro add-hook-fn (name &rest body)
  `(add-hook ,name #'(lambda () ,@body)))

;; 複数の要素をリストに追加
(defmacro append-to-list (to list)
  `(setq ,to (append ,list ,to)))

;; global-set-keyを簡潔に
(defmacro global-set-key-fn (key args &rest body)
  `(global-set-key ,key (lambda ,args ,@body)))

;; 外部ファイルの遅延ロード
(defmacro lazyload (func lib &rest body)
  `(when (locate-library ,lib)
     ,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
     (eval-after-load ,lib
       '(progn ,@body))))

;; ライブラリがあるときだけrequireする
(defmacro req (lib &rest body)
  `(when (locate-library ,(symbol-name lib))
     (require ',lib) ,@body))

;; defadviceを一括登録
(defmacro defadvice-many (fn-lst class &rest body)
  `(progn
     ,@(mapcar
        (lambda (fn)
          `(defadvice ,fn (,class ,(intern (concat (symbol-name fn) "-" (symbol-name class) "-advice")) activate)
             ,@body)) fn-lst)))
