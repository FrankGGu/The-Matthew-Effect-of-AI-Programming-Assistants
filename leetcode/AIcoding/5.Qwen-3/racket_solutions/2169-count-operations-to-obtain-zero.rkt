(define (count-operations a b)
  (let loop ([a a] [b b] [count 0])
    (if (or (= a 0) (= b 0))
        count
        (loop (- a b) b (+ count 1)))))