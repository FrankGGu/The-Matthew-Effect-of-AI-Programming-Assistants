(define/contract (maximum-count nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([pos (length (filter (lambda (x) (> x 0)) nums))]
         [neg (length (filter (lambda (x) (< x 0)) nums))])
    (max pos neg)))