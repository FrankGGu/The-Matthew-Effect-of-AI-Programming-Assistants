(define (distribute-coin-to-max-children money children)
  (if (>= money children)
      (if (= money children)
          1
          (let ((per-child (quotient money children)))
            (if (= (remainder money children) 0)
                per-child
                (if (= (remainder money children) 1)
                    (- per-child 1)
                    per-child))))
      0))