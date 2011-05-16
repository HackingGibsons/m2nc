;; -*- mode: Lisp;  -*-
(asdf:defsystem #:m2nc
  :depends-on (#:m2cl #:unix-options #:cl-ppcre)
  :components ((:static-file "m2nc.asd")
               (:module "src"
                        :components ((:file "package")
                                     (:file "m2nc" :depends-on ("package"))
                                     (:module "cli" :depends-on ("m2nc")
                                              :components ((:file "package")
                                                           (:file "cli" :depends-on ("package"))))))))
                       