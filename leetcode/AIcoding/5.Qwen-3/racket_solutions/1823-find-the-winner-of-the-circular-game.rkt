(define (find-winner n k)
  (define (helper remaining current)
    (if (= remaining 1)
        current
        (helper (- remaining 1) (modulo (+ current k) remaining))))
  (helper n 0))