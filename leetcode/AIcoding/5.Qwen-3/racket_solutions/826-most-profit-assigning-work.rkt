(define (possible-borrowing? a b)
  (<= (car a) (car b)))

(define (assign-work difficulty profit wage)
  (let ([n (length difficulty)])
    (define sorted (sort (map list difficulty profit) (lambda (a b) (< (car a) (car b)))))
    (define max-profit (make-vector n 0))
    (vector-set! max-profit 0 (cadr (vector-ref sorted 0)))
    (for ([i (in-range 1 n)])
      (vector-set! max-profit i (max (cadr (vector-ref sorted i)) (vector-ref max-profit (- i 1)))))
    (define sorted-wage (sort wage <))
    (for/sum ([w (in-list sorted-wage)]
              [i (in-range n)])
      (define idx (binary-search (map car sorted) w))
      (if (>= idx 0)
          (vector-ref max-profit idx)
          0))))

(define (binary-search lst target)
  (define (helper low high)
    (cond [(> low high) -1]
          [else
           (define mid (quotient (+ low high) 2))
           (cond [(= (list-ref lst mid) target) mid]
                 [(< (list-ref lst mid) target) (helper (+ mid 1) high)]
                 [else (helper low (- mid 1))])]))
  (helper 0 (- (length lst) 1)))