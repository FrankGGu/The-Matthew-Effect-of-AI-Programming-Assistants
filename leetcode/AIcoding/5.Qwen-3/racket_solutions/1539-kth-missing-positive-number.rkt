(define (find-kth-missing-positive nums k)
  (let loop ([left 0] [right (sub1 (length nums))] [k k])
    (if (> left right)
        (+ k (add1 left))
        (let* ([mid (quotient (+ left right) 2)]
               [missing (sub1 (- (list-ref nums mid) mid))])
          (if (>= missing k)
              (loop left (sub1 mid) k)
              (loop (add1 mid) right (- k missing)))))))