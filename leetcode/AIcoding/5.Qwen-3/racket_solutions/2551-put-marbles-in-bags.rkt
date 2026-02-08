(define (bag-of-marbles10842 marbles k)
  (define (helper lst)
    (if (<= (length lst) 1)
        0
        (+ (car lst) (helper (cdr lst)))))
  (define sorted (sort marbles <))
  (define n (length sorted))
  (if (<= n k)
      0
      (- (apply + (take-right sorted (sub1 k)))
         (apply + (take sorted (sub1 k))))))