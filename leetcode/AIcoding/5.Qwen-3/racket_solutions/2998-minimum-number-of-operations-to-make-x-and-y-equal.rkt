(define/contract (min-operations x y)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([x x] [y y] [count 0])
    (cond
      [(= x y) count]
      [(> x y) (loop (- x y) y (+ count 1))]
      [else (loop x (- y x) (+ count 1))])))