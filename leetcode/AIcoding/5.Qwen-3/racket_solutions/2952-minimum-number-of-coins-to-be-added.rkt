(define/contract (minimum-amount coins target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([coins coins] [target target] [res 0])
    (cond
      [(null? coins) res]
      [(<= (car coins) target)
       (loop (cdr coins) (- target (car coins)) res)]
      [else
       (loop coins (- target (quotient target (car coins))) (+ res (quotient target (car coins))))])))