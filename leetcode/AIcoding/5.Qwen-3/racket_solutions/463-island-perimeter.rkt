(define (island-perimeter grid)
  (define (get-cell i j)
    (if (and (<= 0 i (sub1 (length grid))) (<= 0 j (sub1 (length (car grid)))))
        (list-ref (list-ref grid i) j)
        0))
  (define (count-surrounding i j)
    (let ([up (get-cell (sub1 i) j)]
          [down (get-cell (add1 i) j)]
          [left (get-cell i (sub1 j))]
          [right (get-cell i (add1 j))])
      (- 4 up down left right)))
  (define (loop i j res)
    (cond [(>= i (length grid)) res]
          [(>= j (length (car grid))) (loop (add1 i) 0 res)]
          [else
           (if (= (get-cell i j) 1)
               (loop i (add1 j) (+ res (count-surrounding i j)))
               (loop i (add1 j) res))]))
  (loop 0 0 0))