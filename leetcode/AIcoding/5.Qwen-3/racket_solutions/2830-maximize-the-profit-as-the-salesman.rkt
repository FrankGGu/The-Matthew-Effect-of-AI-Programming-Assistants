(define (max-profit-assignment skill nums)
  (let* ([sorted (sort (map list skill nums) (lambda (a b) (< (car a) (car b))))])
    (define (helper i j res)
      (if (>= i (length sorted))
          res
          (let* ([s (caar sorted)]
                 [n (cadar sorted)]
                 [new-res (if (<= s j) (+ res n) res)])
            (helper (+ i 1) (max j s) new-res))))
    (helper 0 -1 0)))