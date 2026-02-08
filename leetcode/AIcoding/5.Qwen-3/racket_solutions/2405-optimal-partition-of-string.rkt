(define (partition-string s)
  (define (helper s seen res)
    (if (string=? s "")
        res
        (let ((c (string-ref s 0)))
          (if (member c seen)
              (helper (substring s 1) (list c) (+ res 1))
              (helper (substring s 1) (cons c seen) res)))))
  (helper s '() 0))