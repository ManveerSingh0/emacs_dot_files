(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;;Load theme
(load-theme 'dracula t)


;; Load helm
(add-to-list 'load-path "~/.emacs.d/helm")


;; Enable Helm
(helm-mode 1)

;; Key Bindings for accessing Helm easily
(global-set-key (kbd "M-x") 'helm-M-x)	
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)


;;settings keybinding for buffer movement
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)


;; Set the default font for Emacs
(set-frame-font "Iosevka Bold-14" nil t)

(tool-bar-mode -1)
(menu-bar-mode -1)
;; Disable backup files (files ending with ~)
(setq make-backup-files nil)

;; Disable auto-save files (files starting and ending with #)
(setq auto-save-default nil)

;; Disable lock files (files starting with .#)
(setq create-lockfiles nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(package-selected-packages '(lsp-mode smartparens dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Calibri" :foundry "outline" :slant normal :weight regular :height 120 :width normal)))))
