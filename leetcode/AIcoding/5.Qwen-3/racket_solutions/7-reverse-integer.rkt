(define (reverse-x x)
  (define (reverse-helper x reversed)
    (if (= x 0)
        reversed
        (reverse-helper (quotient x 10) (+ (* reversed 10) (remainder x 10)))))
  (let ((reversed (reverse-helper x 0)))
    (if (or (< reversed -2147483648) (> reversed 2147483647))
        0
        reversed)))