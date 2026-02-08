(define (dynamic-password password)
  (define (helper s i)
    (if (= i (string-length s))
        ""
        (string-append (substring s i (+ i 1)) (helper s (+ i 1)))))
  (helper password 0))