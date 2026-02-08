(define/contract (number-of-smooth-descent-periods prices)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([prices prices] [count 0] [prev 0])
    (if (null? prices)
        count
        (let ([current (car prices)])
          (if (or (null? (cdr prices)) (< current (- prev 1)))
              (loop (cdr prices) (+ count 1) current)
              (loop (cdr prices) count current))))))