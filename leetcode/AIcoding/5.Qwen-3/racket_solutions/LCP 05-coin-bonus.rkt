(define (coin-bonus coins)
  (define (helper coins count)
    (if (null? coins)
        count
        (let ((coin (car coins)))
          (if (= coin 5)
              (helper (cdr coins) (+ count 1))
              (helper (cdr coins) count)))))
  (helper coins 0))