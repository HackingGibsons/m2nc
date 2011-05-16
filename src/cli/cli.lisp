(in-package :m2nc-cli)

(defun read-dot-m2nc ()
  (let ((dot-m2nc (make-pathname :name ".m2nc")))
    (if (probe-file dot-m2nc)
        (with-open-file (stream dot-m2nc)
          (let ((m2nc-params (read stream)))
            (values m2nc-params)))
        (values))))

(defun get-option-default (name default-list)
  (let ((option (assoc name default-list)))
    (if option 
        (cdr option))))

;;; turn in to macro that generates this kind of structure automatically
(defun process-arguments (sub pub type file-path)
  (let ((dot-values (read-dot-m2nc)))
    (unless sub 
      (setf sub (get-option-default :sub dot-values)))
    (unless pub 
      (setf pub (get-option-default :pub dot-values)))
    (unless type
      (setf type (or (get-option-default :type dot-values) *default-content-type*)))
    (unless file-path 
      (setf file-path (or (get-option-default :file-path dot-values) *default-input*))))
  (values sub pub type file-path))

(defun start-handler-with-options (args) 
  (unix-options:with-cli-options (args t)
      (unix-options:&PARAMETERS (sub "sub address") (pub "pub address") (type "Content-Type header is set to this value.") unix-options:&free file-path)
    (unless (<= (length file-path) 1) 
      (format *standard-output* "A single file path was expected, but multiple were passed.")
      (sb-ext:quit :unix-status 1))
    (multiple-value-bind (sub pub type file-path) (process-arguments sub pub type file-path)
      (if (stringp (cdr file-path))
          (setf file-path (cond ((string-equal "-" (cdr file-path)) *default-input*)
                                (t (make-pathname :name (cdr file-path)))))
          (setf file-path *default-input*))
      (if (not (reduce #'(lambda (acc arg) 
                           (and acc arg)) (list pub sub type file-path)))
          (start-handler-with-options '("-h")) ;; display help if any processed arguments are nil
          (m2cl:with-handler (m2nc-handler "m2nc" sub pub)
            (m2nc-input-handler m2nc-handler file-path type))))))
                