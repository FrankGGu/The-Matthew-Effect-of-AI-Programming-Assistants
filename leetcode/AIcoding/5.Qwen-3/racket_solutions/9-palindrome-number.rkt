(define (is-palindrome x)
  (if (negative? x)
      #f
      (let ((s (number->string x)))
        (equal? s (reverse s)))))