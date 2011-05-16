(in-package :m2nc)

(defun chunk-input (handler stream)
  (loop for line = (read-line stream nil)
     until (eq line nil)
     do (m2cl:handler-send-http-chunk handler line)))

(defun m2nc-input-handler (handler input-file-path content-type)
  (m2cl:handler-receive handler)
  (m2cl:handler-send-http-chunked handler :headers `(("Content-Type" . ,content-type)))
  (cond ((eql input-file-path *default-input*) (chunk-input handler input-file-path))
        ((pathnamep input-file-path) (with-open-file (input-stream input-file-path)
                                       (chunk-input handler input-stream))))
  (m2cl:handler-send-http-chunked-finish handler))




      
      
      
      