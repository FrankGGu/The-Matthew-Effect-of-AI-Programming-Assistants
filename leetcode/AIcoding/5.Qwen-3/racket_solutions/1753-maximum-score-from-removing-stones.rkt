(define/contract (maximum-score a b)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([a a] [b b] [score 0])
    (if (or (= a 0) (= b 0))
        score
        (loop (min a b) (abs (- a b)) (+ score (min a b))))))