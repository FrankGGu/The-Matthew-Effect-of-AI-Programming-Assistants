(define (broken-calculator x y)
  (cond [(>= x y) (- x y)]
        [else
         (let loop ([x x] [y y] [count 0])
           (if (>= x y)
               (+ count (- x y))
               (loop (add1 (* x 2)) y (add1 count))))]))