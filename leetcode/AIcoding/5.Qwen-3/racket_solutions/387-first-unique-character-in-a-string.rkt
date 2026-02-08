(define (first-unique-char s)
  (let ((count (make-hash)))
    (for-each (lambda (c) (hash-set! count c (+ 1 (hash-ref count c 0)))) (string->list s))
    (let loop ((i 0))
      (if (= i (string-length s))
          -1
          (let ((c (string-ref s i)))
            (if (= 1 (hash-ref count c))
                i
                (loop (+ i 1))))))))