(bbdb-initialize 'message 'mu4e 'pgp 'anniv)
(setq bbdb-file "~/Dropbox/bbdb.gpg")
(setq bbdb-complete-name-full-completion t)
(setq bbdb-completion-type 'primary-or-name)
(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-mail-user-agent 'mu4e-user-agent)
(setq mu4e-view-mode-hook 'bbdb-mua-auto-update)
(setq mu4e-compose-complete-addresses nil)
(setq bbdb-mua-pop-up t)
(setq bbdb-mua-pop-up-window-size 5)
(setq mu4e-view-show-addresses t)
