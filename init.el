 ;;(elpaca-no-symlink-mode) ; Keep commented unless needed
(setq package-enable-at-startup nil)
(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))

(let* ((repo (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive)))))

(unless (require 'elpaca-autoloads nil t)
  (require 'elpaca)
  (elpaca-generate-autoloads "elpaca" repo)
  (let ((load-source-file-function nil)) (load "./elpaca-autoloads")))

(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))
(elpaca elpaca-use-package
  (elpaca-use-package-mode))

(global-set-key (kbd "C-c j") 'windmove-left)
(global-set-key (kbd "C-c k") 'windmove-down)
(global-set-key (kbd "C-c l") 'windmove-up)
(global-set-key (kbd "C-c ;") 'windmove-right)
















(setq make-backup-files nil)
(setq make-backup-files nil)      ; Disable backup files (ending with ~)
(setq auto-save-default nil)      ; Disable auto-save files (starting/ending with #)
(setq create-lockfiles nil)       ; Disable lock files (starting with .#)






(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)

(use-package color-theme-sanityinc-tomorrow
  :ensure (:host github :repo "purcell/color-theme-sanityinc-tomorrow")
  :config
  (color-theme-sanityinc-tomorrow-night))




(use-package eglot
  :ensure (:host github :repo "joaotavora/eglot" :files ("eglot.el" (:exclude ".git")))
  :hook
  ;; (c++-mode . eglot-ensure)
  ;; (emacs-lisp-mode  . eglot-ensure)
  (c++-mode . eglot-ensure)
  (emacs-lisp-mode . eglot-ensure))

(use-package company
  :ensure t
  :hook
  (c++-mode . company-mode)
  (emacs-lisp-mode  . company-mode))


(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode))

(use-package cmake-mode
  :ensure t)
(use-package vterm
  :ensure t)

(use-package magit
  :ensure (:host github :repo "magit/magit"))


(use-package dashboard
  :ensure (:host github :repo "emacs-dashboard/emacs-dashboard")
  :config
  (setq dashboard-startup-banner "~/.emacs.d/logo/dashboard.png")
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-banner-logo-title "Welcome Manveer")
  (setq dashboard-footer-messages '("Consistency is the key"))
  (setq dashboard-items '((projects . 5)
			  (recents . 5)
			  (bookmarks . 5)))
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-list)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))


(use-package projectile
  :ensure t)


(use-package helm
  :ensure (:host github :repo "emacs-helm/helm")
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-x r b") #'helm-bookmarks)
  (global-set-key (kbd "C-x b") #'helm-buffers-list))

(use-package helm-projectile
  :ensure (:host github :repo "bbatsov/helm-projectile")
  :config
  (helm-projectile-on) ; Enable Helm-Projectile integration
  :bind
  (("C-c p p" . helm-projectile-switch-project)
   ("C-c p f" . helm-projectile-find-file)
   ("C-c p s" . helm-projectile-switch-to-buffer)))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-eighties))
 '(custom-safe-themes
   '("04aa1c3ccaee1cc2b93b246c6fbcd597f7e6832a97aaeac7e5891e6863236f9f"
     "b11edd2e0f97a0a7d5e66a9b82091b44431401ac394478beb44389cf54e6db28"
     "76ddb2e196c6ba8f380c23d169cf2c8f561fd2013ad54b987c516d3cabc00216"
     "6bdc4e5f585bb4a500ea38f563ecf126570b9ab3be0598bdf607034bb07a8875"
     "6fc9e40b4375d9d8d0d9521505849ab4d04220ed470db0b78b700230da0a86c1"
     default))
 '(global-display-line-numbers-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Adwaita Mono" :foundry "UKWN" :slant normal :weight regular :height 126 :width normal)))))
