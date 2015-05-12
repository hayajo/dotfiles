;; C-w(kil-region)で前の単語を削除
;; リージョン選択をしている場合は普通にkill-regionする
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p)
	   transient-mark-mode
	   (not mark-active))
      (backward-kill-word 1)
    ad-do-it))
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word) ;ミニバッファでも使用可

;; kill-lineで行が連結したときにインデントを削除
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;; windowを分割・削除したときに幅をあわせる＆別のwindowに移動
(defadvice-many (split-window-vertically
                 split-window-horizontally)
  after
  (balance-windows))
(defadvice delete-window (after delete-window-after-advice activate)
  (balance-windows))
