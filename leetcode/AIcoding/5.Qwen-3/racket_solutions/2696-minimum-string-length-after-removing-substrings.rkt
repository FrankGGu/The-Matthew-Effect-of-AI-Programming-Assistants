(define (min-string-length s)
  (define (remove-substrings s)
    (let loop ([s s])
      (let ([new-s (string-replace s "AB" "")])
        (if (equal? new-s s)
            s
            (loop new-s)))))
  (string-length (remove-substrings s)))