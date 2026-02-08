(define (find-indices nums index-diff value-diff)
  (define n (length nums))
  (for/list ([i (in-range n)])
    (let ([min-val (apply min (take nums i))]
          [max-val (apply max (drop nums (+ i 1)))])
      (if (and (<= (- i 0) index-diff) (>= (- max-val min-val) value-diff))
          i
          #f))))