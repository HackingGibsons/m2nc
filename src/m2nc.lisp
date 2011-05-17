(in-package :m2nc)

(defparameter *write-buf* (make-sequence 'string 8 :initial-element #\0))

(defun chunk-input (handler request stream)
  (let ((length (length *write-buf*)))
    (loop for pos = (read-sequence *write-buf* stream)
       until (= pos 0) ;; when pos is 0 it means it failed to update any elements in the sequence
       do (m2cl:handler-send-http-chunk handler (if (< pos length)
                                                    (subseq *write-buf* 0 pos)
                                                    *write-buf*) :request request))))

(defun m2nc-input-handler (handler input-file-path content-type)
  (let ((request (m2cl:handler-receive handler)))
        (m2cl:handler-send-http-chunked handler :headers `(("Content-Type" . ,content-type)) :request request)
        (cond ((eql input-file-path *default-input*) (chunk-input handler request input-file-path))
              ((pathnamep input-file-path) (with-open-file (input-stream input-file-path)
                                             (chunk-input handler request input-stream))))
        (m2cl:handler-send-http-chunked-finish handler :request request)))




      
      
      
      