#!/usr/bin/env sbcl --script
;; -*- mode: Lisp;  -*-
;; Load an RC if we can find it
(let ((rc (probe-file #P"~/.sbclrc")))
  (when rc (load rc)))

(ql:quickload :m2nc)
(m2nc-cli:start-handler-with-options sb-ext:*posix-argv*)
(quit)
