(define (bag-of-balls nums limit)
  (define (can-achieve? mid)
    (for/and ([n nums])
      (<= (quotient n mid) limit)))

  (define (binary-search left right)
    (if (>= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (can-achieve? mid)
              (binary-search left mid)
              (binary-search (add1 mid) right)))))

  (binary-search 1 (apply max nums)))