;; 关闭工具栏, tool-bar-mode 即为一个minor-mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode 1)

;; 更改光标的样式
(setq-default cursor-type 'bar)

;; 关闭启动帮助动画
(setq inhibit-splash-screen 1)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; (set-face-attribute 'default nil :height 160)
(set-default-font "consolas 16")

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el")
)

;; 绑定open-init-file函数为快捷键F2
(global-set-key (kbd "<f2>") 'open-init-file)

;; 开启全局自动补全
;; 这里处理的不够好, 路径写死了, 应该把路径泛化
(load-file "~/.emacs.d/elpa/company-0.9.0/company.el")
(global-company-mode t)

;; 不自动生成备份文件
(setq make-backup-files nil)

;; 打开最近文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; 打开最近文件的快捷键
;; (global-set-key (kbd "C-x C-r") 'recent-open-files)

;; 仅替换选中文字
(delete-selection-mode 1)

;; 软件包管理
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
	       ;; --- Auto-completion ---
	       company

	       ;; --- Better Editor ---
	       hungry-delete
	       swiper
	       counsel
	       smartparens

	       ;; --- Major Mode ---
	       ;; js2-mode
	       cc-mode
	       csharp-mode
	       
	       ;; --- Minor Mode ---
	       ;; nodejs-repl
	       ;; exec-path-from-shell

	       ;; --- Themes ---
	       color-theme-sanityinc-tomorrow
	       ;; monokai-theme
	       ;; solarized-theme
	       ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
    (loop for pkg in my/packages
	  when (not (package-installed-p pkg)) do (return nil)
	  finally (return t)))

(unless (my/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
	(package-install pkg))))

;; Find Executable Path on OS X
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

;; 安装主题(不需要了, 而且名字不对)
;; (add-to-list my/packages 'sanityinc-tomorrow-night)

;; 载入主题
(load-theme 'sanityinc-tomorrow-eighties t)

;; emacs开启时默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 自动括号匹配(还没有加载文件)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 高亮当前行
(global-hl-line-mode 1)

;; hungry-delete 配置
(global-hungry-delete-mode)

;; smart-parent配置
(require 'smartparens-config)
(smartparens-global-mode t)

;; org相关
(require 'org)
(setq org-src-fontify-natively t)

;; 自动加载文件外部修改
(global-auto-revert-mode t)

