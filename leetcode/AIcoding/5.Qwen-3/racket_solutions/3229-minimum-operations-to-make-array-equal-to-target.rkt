(define/contract (min-operations nums target)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [target target] [ops 0])
    (if (equal? nums target)
        ops
        (loop (map - nums target) (map - target nums) (+ ops 1)))))