(define (gcd-of-strings str1 str2)
  (define (gcd a b)
    (if (zero? b)
        a
        (gcd b (modulo a b))))
  (define len (gcd (string-length str1) (string-length str2)))
  (define candidate (substring str1 0 len))
  (if (and (string=? (string-append (make-string (quotient (string-length str1) len) candidate) "") str1)
           (string=? (string-append (make-string (quotient (string-length str2) len) candidate) "") str2))
      candidate
      ""))