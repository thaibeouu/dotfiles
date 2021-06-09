;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     (ruby :variables
           ;; ruby-enable-enh-ruby-mode t
           ;; ruby-version-manager 'rbenv
           ruby-test-runner 'rspec
           ruby-backend 'robe)
     ruby-on-rails
     (rust :variables rust-backend 'lsp)
     ;; (reasonml :variables reason-auto-refmt t)
     ;; (python :variables python-backend 'anaconda)
     ;; (php :variables php-backend 'lsp)
     (typescript :variables
                 tide-tsserver-executable "/usr/bin/tsserver"
                 typescript-backend 'lsp)
     multiple-cursors
     ;; elixir
     ;; phoenix
     docker
     shell-scripts
     xkcd
     twitter
     search-engine
     eww
     (html :variables web-fmt-tool 'prettier)
     ;; web-beautify
     prettier
     (javascript :variables
                 javascript-fmt-tool 'prettier
                 javascript-import-tool 'import-js
                 node-add-modules-path t
                 tide-tsserver-executable "/usr/bin/tsserver"
                 javascript-backend 'tide)
     tern
     react
     ;; vue
     (json :variables json-fmt-tool 'prettier)
     yaml
     xclipboard
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (go :variables
         go-backend 'lsp
         go-tab-width 4
         godoc-at-point-function 'godoc-gogetdoc)
         ;; go-use-golangci-lint t)
     ;; (java :variables java-backend 'lsp)
     (version-control :variables
                       version-control-diff-tool 'git-gutter+)
     ;; (ruby :variables
     ;;       ruby-version-manager 'rvm
     ;;       ruby-test-runner 'rspec)
     (markdown :variables markdown-live-preview-engine 'vmd)
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-idle-delay 0.1
                      auto-completion-private-snippets-directory nil
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t)
     better-defaults
     emacs-lisp
     multiple-cursors
     (treemacs :variables
               treemacs-use-filewatch-mode t
               treemacs-use-git-mode 'simple
               treemacs-use-follow-mode t)
     (org :variables
          org-enable-sticky-header t
          org-enable-org-journal-support t
          org-journal-file-format "%Y%m%d.org"
          org-enable-github-support t)
     git
     restclient
     ;; colors
     (colors :variables colors-enable-nyan-cat-progress-bar (display-graphic-p))
     (shell :variables
            shell-default-height 30
            shell-default-shell 'vterm
            shell-default-term-shell "/usr/bin/zsh"
            multi-term-program "/usr/bin/zsh"
            shell-enable-smart-eshell t
            shell-default-position 'bottom)
     ;; (terraform :variables terraform-auto-format-on-save t)
     (lsp :variables lsp-rust-server 'rust-analyzer)
     dap
     spell-checking
     (syntax-checking :variables syntax-checking-enable-tooltips t)
     typography
     (ranger :variables
             ranger-override-dired 'ranger
             ranger-show-preview t)
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(doom-themes dap-mode all-the-icons spaceline-all-the-icons exec-path-from-shell poke-line find-file-in-project)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)

   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-28.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'random

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 9)
                                (agenda . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   ;; dotspacemacs-themes '(
   ;;                       doom-challenger-deep
   ;;                       (sanityinc-tomorrow-night :location (recipe :fetcher github
   ;;                                                                   :repo "purcell/color-theme-sanityinc-tomorrow"))
   ;;                       spacemacs-dark)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator nil :separator-scale 0.8)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Roboto Mono"
                               :powerline-scale 1.00
                               :size 14
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 10

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.1

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup t

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 95

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   ;; dotspacemacs-inactive-transparency 85

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfer with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  ;; (defun set-exec-path-from-shell-PATH ()
  ;;   (interactive)
  ;;   (let ((path-from-shell (replace-regexp-in-string
	;; 		                      "[ \t\n]*$" "" (shell-command-to-string
	;; 				                                  "$SHELL --login -i -c 'echo $PATH'"
	;; 					                                ))))
  ;;     (setenv "PATH" path-from-shell)
  ;;     (setq exec-path (split-string path-from-shell path-separator))))

  ;; (set-exec-path-from-shell-PATH)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;; nano-emacs
  ;; (add-to-list 'load-path "/home/radiohead/nano-emacs")
  ;; (add-to-list 'load-path ".")
  ;; (add-to-list 'command-switch-alist '("-dark"   . (lambda (args))))
  ;; (add-to-list 'command-switch-alist '("-light"  . (lambda (args))))
  ;; (add-to-list 'command-switch-alist '("-default"  . (lambda (args))))
  ;; (add-to-list 'command-switch-alist '("-no-splash" . (lambda (args))))
  ;; (add-to-list 'command-switch-alist '("-no-help" . (lambda (args))))
  ;; (add-to-list 'command-switch-alist '("-compact" . (lambda (args))))
  ;; (cond
  ;;  ((member "-default" command-line-args) t)
  ;;  ((member "-dark" command-line-args) (require 'nano-theme-dark))
  ;;  (t (require 'nano-theme-light)))
  ;; (require 'nano-faces)
  ;; (nano-faces)
  ;; (require 'nano-theme)
  ;; (nano-theme)
  ;; (provide 'nano)

  (setq-default git-magit-status-fullscreen t)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/bin"))
  (setq exec-path (append exec-path '("/usr/bin")))
  ;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
  ;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  ;; (setq exec-path (append exec-path '("/home/radiohead/.gem/bin")))
  ;; (setenv "SHELL" "/usr/local/bin/zsh")
  ;; (add-to-list 'exec-path "/home/radiohead/.gem/bin/")
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  ;; (require 'dap-ruby)
  ;; (require 'dap-firefox)
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;; '(add-hook 'ruby-mode-hook 'eglot-ensure)
  ;; (add-hook 'ruby-mode-hook 'lsp)
  ;; (dd-hook 'lsp-mode-hook (lambda () (setq flycheck-checker 'javascript-eslint)))
  ;; (add-hook 'js2-mode-hook (lambda () (setq flycheck-checker 'javascript-eslint)))
  ;; (add-hook 'js2-mode-hook (lambda ()
  ;;                            (flycheck-mode)
  ;;                            (flycheck-select-checker 'javascript-eslint)))
  ;; (doom-themes-treemacs-config)
  ;; (evil-leader/set-key "/" 'spacemacs/helm-project-do-ag)
  ;; (evil-leader/set-key "/" 'counsel-ag)
  ;; (setq js2-mode-show-parse-errors nil)
  ;; (setq js2-mode-show-strict-warnings nil)
  ;; (evil-leader/set-key "/" 'spacemacs/helm-project-do-ag)
  (setq-default typescript-indent-level 2)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (setq spaceline-all-the-icons-separator-type 'none)
  (require 'find-file-in-project)
  (setq ffip-use-rust-fd t)
  (setq create-lockfiles nil)
  ;; (fset 'mx-tradezone
  ;;       (kmacro-lambda-form [?: ?% ?s ?/ ?/ backspace ?/ ?g backspace backspace ?, ?  ?/ ?  ?/ ?g return ?: ?% ?s ?/ ?, ?  ?/ ?  backspace backspace backspace ?/ ?  ?/ ?g return ?: ?% ?s ?/ ?  ?\\ ?\] ?  ?\\ ?\[ ?/ ?, ?/ ?g return ?: ?% ?s ?/ ?  ?\\ ?\] ?  ?\\ ?\] ?/ ?\) ?\) return ?: ?% ?s ?/ ?\\ ?\[ ?  ?\\ ?\[ ?  ?/ ?P ?O ?L ?Y ?G ?O ?N ?\S-  ?\( ?\( return] 0 "%d"))
  (use-package spaceline-all-the-icons 
    :after spaceline
    :config
    (spaceline-all-the-icons-theme)
    )
  ;; (use-package poke-line
  ;;   :ensure t
  ;;   :config
  ;;   (poke-line-global-mode 1)
  ;;   (setq poke-line-minimum-window-width 64)
  ;;   (setq poke-line-bar-length 32)
  ;;   (setq poke-line-pokemon "dragonite")
  ;;   (setq-default poke-line-pokemon "dratini"))

  (use-package doom-themes
    :config
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-badger t)

    (doom-themes-visual-bell-config)
    ;; (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
    ;; (doom-themes-treemacs-config)
    (doom-themes-org-config))

  ;; (require 'flycheck) 
  ;; (flycheck-add-mode 'javascript-eslint 'js2-mode)

  ;; (defun my/configure-web-mode-flycheck-checkers ()
  ;;   (-when-let (checker (cond
  ;;                        ((string= web-mode-content-type "js")
  ;;                         'javascript-eslint)))
  ;;     (flycheck-mode)
  ;;     (flycheck-select-checker checker)))

  ;; (add-hook 'web-mode-hook #'my/configure-web-mode-flycheck-checkers)
  (spacemacs/enable-transparency)
  ;; (setq org-agenda-files (list "~/Documents/org/work.org"
  ;;                              "~/Documents/org/home.org"))

  ;; '(counsel-rg-base-command "rg -C 3")
  ;; '(helm-ag-base-command "rg --vimgrep --no-ignore --smart-case --no-heading -C 3")
  (defun my-setup-indent (n)
    ;; java/c/c++
    (setq c-basic-offset n)
    ;; web development
    (setq coffee-tab-width n) ; coffeescript
    (setq javascript-indent-level n) ; javascript-mode
    (setq js-indent-level n) ; js-mode
    (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
    (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
    (setq web-mode-css-indent-offset n) ; web-mode, css in html file
    (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
    (setq css-indent-offset n) ; css-mode
    (setq create-lockfiles nil) ; lockfiles
    )
  (my-setup-indent 2)
  ;; (exec-path-from-shell-initialize)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(evil-undo-system 'undo-redo)
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#858FA5")
 '(jdee-db-active-breakpoint-face-colors (cons "#100e23" "#906cff"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#100e23" "#95ffa4"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#100e23" "#565575"))
 '(js-indent-level 2)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(objed-cursor-color "#ff8080")
 '(package-selected-packages
   '(ranger find-file-in-project poke-line rubocopfmt projectile-rails inflections feature-mode inf-ruby github-search github-clone gist gh marshal logito forge ghub closql emacsql-sqlite emacsql treepy ansi package-build shut-up epl git commander f dash s utop tuareg caml reason-mode ocp-indent flycheck-ocaml merlin dune sqlup-mode sql-indent typo insert-shebang flycheck-bashate fish-mode company-shell csv-mode toml-mode racer flycheck-rust cargo rust-mode yapfify stickyfunc-enhance pytest pyenv-mode py-isort pippel pipenv pyvenv pip-requirements lsp-python-ms python live-py-mode importmagic epc ctable concurrent deferred helm-pydoc helm-cscope cython-mode counsel swiper ivy company-anaconda blacken anaconda-mode pythonic phpunit phpcbf php-extras php-auto-yasnippets drupal-mode company-php ac-php-core xcscope php-mode dockerfile-mode docker tablist docker-tramp hackernews restclient-helm ob-restclient ob-http company-restclient restclient know-your-http-well company-terraform terraform-mode hcl-mode tide typescript-mode import-js grizzl vmd-mode flyspell-correct doom-themes xkcd rjsx-mode ob-elixir helm-gtags ggtags flycheck-mix flycheck-credo counsel-gtags alchemist elixir-mode livid-mode skewer-mode json-navigator hierarchy json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern tern web-mode web-beautify tagedit slim-mode scss-mode sass-mode pug-mode prettier-js impatient-mode simple-httpd helm-css-scss haml-mode emmet-mode counsel-css company-web web-completion-data add-node-modules-path exec-path-from-shell godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc flycheck-golangci-lint company-go go-mode helm-rg dap-mode zenburn-theme yasnippet-snippets yaml-mode xterm-color ws-butler writeroom-mode winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package unfill treemacs-projectile treemacs-evil toc-org tao-theme symon string-inflection spaceline-all-the-icons soft-stone-theme smeargle shell-pop seeing-is-believing sanityinc-tomorrow-theme rvm ruby-tools ruby-test-mode ruby-refactor ruby-hash-syntax rubocop rspec-mode robe restart-emacs rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters popwin persp-mode password-generator paradox overseer orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets org-brain open-junk-file nameless mwim multi-term move-text mmm-mode minitest markdown-toc magit-svn magit-gitflow macrostep lsp-ui lorem-ipsum link-hint indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-org-rifle helm-mode-manager helm-make helm-gitignore helm-git-grep helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag gruvbox-theme google-translate golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy font-lock+ flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav eglot editorconfig dumb-jump dotenv-mode doom-modeline diminish diff-hl define-word counsel-projectile company-statistics company-quickhelp company-lsp column-enforce-mode color-identifiers-mode clean-aindent-mode chruby centered-cursor-mode bundler browse-at-remote auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent ace-link ace-jump-helm-line ac-ispell))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(safe-local-variable-values
   '((org-confirm-babel-evaluate)
     (typescript-backend . tide)
     (typescript-backend . lsp)
     (javascript-backend . tide)
     (javascript-backend . tern)
     (javascript-backend . lsp)
     (go-backend . go-mode)
     (go-backend . lsp)))
 '(vc-annotate-background "#1b182c")
 '(vc-annotate-color-map
   (list
    (cons 20 "#95ffa4")
    (cons 40 "#b8f7a6")
    (cons 60 "#dbf0a8")
    (cons 80 "#ffe9aa")
    (cons 100 "#ffd799")
    (cons 120 "#ffc488")
    (cons 140 "#ffb378")
    (cons 160 "#eda79b")
    (cons 180 "#db9cbd")
    (cons 200 "#c991e1")
    (cons 220 "#db8bc0")
    (cons 240 "#ed85a0")
    (cons 260 "#ff8080")
    (cons 280 "#d4757d")
    (cons 300 "#aa6a7a")
    (cons 320 "#805f77")
    (cons 340 "#858FA5")
    (cons 360 "#858FA5")))
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-types '((comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
