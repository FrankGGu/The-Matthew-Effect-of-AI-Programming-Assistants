(define (smallest-even-multiple n)
  (if (= (modulo n 2) 0)
      n
      (* n 2)))