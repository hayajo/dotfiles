(when (require 'color-theme nil t)
  (color-theme-initialize)
  (if (require 'color-theme-desert nil t)
      (color-theme-desert)))
