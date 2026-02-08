(define (find-copies files)
  (let ((count (make-hash)))
    (for-each
     (lambda (file)
       (hash-update! count file add1 0))
     files)
    (filter
     (lambda (file)
       (> (hash-ref count file) 1))
     (remove-duplicates files))))