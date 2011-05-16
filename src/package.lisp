(defpackage #:m2nc
  (:use #:cl)
  (:export :m2nc-input-handler
           :*default-input*
           :*default-content-type*))

(in-package :m2nc)

(defparameter *default-input* *standard-input* 
  "input to with which to reply 
can be either *standard-input* or a file path")

(defparameter *default-content-type* "text/html"
  "by default m2nc will send back everything as text/html")