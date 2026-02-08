(define (sort-array-by-parity-ii nums)
  (let loop ([i 0] [j 1] [nums nums])
    (cond
      [(>= i (length nums)) nums]
      [(and (even? (list-ref nums i)) (even? i)) (loop (+ i 2) j nums)]
      [(and (odd? (list-ref nums i)) (odd? i)) (loop i (+ j 2) nums)]
      [else
       (let ([temp (list-ref nums i)])
         (list-set! nums i (list-ref nums j))
         (list-set! nums j temp)
         (loop (+ i 2) (+ j 2) nums))])))