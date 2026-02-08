(define (minimum-time-to-revert-word-to-initial-state word k)
  (define len (string-length word))
  (define (check i)
    (and (<= i len) (equal? (substring word i len) (substring word 0 (- len i)))))
  (let loop ((i 0))
    (if (>= i len)
        len
        (if (check i)
            i
            (loop (+ i k))))))