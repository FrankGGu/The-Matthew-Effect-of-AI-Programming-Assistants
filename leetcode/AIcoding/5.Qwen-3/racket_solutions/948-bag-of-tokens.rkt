(define/contract (bag-of-tokens tokens power)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([tokens (sort tokens <)] [power power] [score 0] [left 0] [right (sub1 (length tokens))])
    (cond
      [(<= left right)
       (if (>= power (list-ref tokens left))
           (loop (cdr tokens) (+ power (list-ref tokens left)) (+ score 1) (add1 left) right)
           (if (> score 0)
               (loop tokens (- power (list-ref tokens right)) (- score 1) left (sub1 right))
               0))]
      [else score])))