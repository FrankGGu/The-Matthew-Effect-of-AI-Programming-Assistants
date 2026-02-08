(define (find-min nums)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (<= left right)
        (let ([mid (quotient (+ left right) 2)])
          (cond [(> (list-ref nums right) (list-ref nums mid)) (loop left (sub1 mid))]
                [(< (list-ref nums right) (list-ref nums mid)) (loop (add1 mid) right)]
                [else (loop (sub1 right) right)]))
        (list-ref nums left))))