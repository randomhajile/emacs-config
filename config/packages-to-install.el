(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(unless (package-installed-p 'quelpa-use-package)
  (package-install 'quelpa-use-package))

(require 'quelpa-use-package)
(use-package dired+
  :quelpa (dired+ :fetcher url :url "https://www.emacswiki.org/emacs/download/dired+.el"))
(use-package guess-style
  :quelpa (guess-style :fetcher github :repo "nschum/guess-style"))
(use-package auto-complete :ensure t)
(use-package autopair :ensure t)
(use-package avy :ensure t)
(use-package cargo :ensure t)
(use-package cl-lib :ensure t)
(use-package company :ensure t)
(use-package dash :ensure t)
(use-package dired-subtree :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package editorconfig :ensure t)
(use-package elpy :ensure t)
(use-package enh-ruby-mode :ensure t)
(use-package exec-path-from-shell :ensure t)
(use-package fill-column-indicator :ensure t)
(use-package find-file-in-project :ensure t)
(use-package flycheck :ensure t)
(use-package fuzzy :ensure t)
(use-package git-gutter :ensure t)
(use-package go-mode :ensure t)
(use-package highlight-indentation :ensure t)
(use-package idomenu :ensure t)
(use-package js2-mode :ensure t)
(use-package js2-refactor :ensure t)
(use-package json-mode :ensure t)
(use-package magit :ensure t)
(use-package markdown-mode :ensure t)
(use-package night-owl-theme :ensure t)
(use-package nim-mode :ensure t)
(use-package php-mode :ensure t)
(use-package py-autopep8 :ensure t)
(use-package pyvenv :ensure t)
(use-package rg :ensure t)
(use-package robe :ensure t)
(use-package rubocop :ensure t)
(use-package rust-mode :ensure t)
(use-package rvm :ensure t)
(use-package s :ensure t)
(use-package slime :ensure t)
(use-package sml-mode :ensure t)
(use-package terraform-mode :ensure t)
(use-package tuareg :ensure t)
(use-package undo-tree :ensure t)
(use-package virtualenvwrapper :ensure t)
(use-package web-mode :ensure t)
(use-package with-editor :ensure t)
(use-package xcscope :ensure t)
(use-package xref-js2 :ensure t)
(use-package yaml-mode :ensure t)
(use-package yasnippet :ensure t)
