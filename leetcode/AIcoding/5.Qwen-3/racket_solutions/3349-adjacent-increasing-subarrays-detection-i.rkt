(define (good-subarray? nums)
  (let loop ([i 0] [j 1])
    (cond [(>= j (length nums)) #f]
          [(> (list-ref nums j) (list-ref nums (- j 1)))
           (loop (+ i 1) (+ j 1))]
          [else
           (if (>= i 1)
               #t
               (loop 0 (+ j 1)))])))