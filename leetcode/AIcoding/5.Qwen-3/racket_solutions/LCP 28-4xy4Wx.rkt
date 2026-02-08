(define/contract (num-possible-choices cost target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([costs cost] [target target] [count 0])
    (cond
      [(null? costs) count]
      [(= (car costs) target) (loop (cdr costs) target (+ count 1))]
      [(< (car costs) target) (loop (cdr costs) target (+ count (loop (cdr costs) (- target (car costs)) 0)))]
      [else (loop (cdr costs) target count)])))