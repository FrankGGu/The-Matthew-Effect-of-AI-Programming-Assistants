(define (subset-xor-sum nums)
  (define (helper index current)
    (if (= index (length nums))
        current
        (+ (helper (+ index 1) (bitwise-xor current (list-ref nums index)))
           (helper (+ index 1) current))))
  (helper 0 0))