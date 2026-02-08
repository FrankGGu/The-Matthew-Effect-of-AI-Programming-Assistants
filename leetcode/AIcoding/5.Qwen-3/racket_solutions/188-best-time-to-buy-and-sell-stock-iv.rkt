(define (max-profit k prices)
  (cond [(<= k 0) 0]
        [(<= (length prices) 1) 0]
        [else
         (let ([n (length prices)])
           (if (>= k n)
               (apply + (map (lambda (i) (- (list-ref prices i) (list-ref prices (sub1 i)))) (range 1 n)))
               (let ([dp (make-vector (+ k 1) 0)]
                     [prev (make-vector (+ k 1) 0)])
                 (for ([i (in-range 1 n)])
                   (for ([j (in-range k 0 -1)])
                     (vector-set! dp j (max (vector-ref dp j) (+ (vector-ref prev (- j 1)) (- (list-ref prices i) (list-ref prices (sub1 i)))))))
                   (set! prev dp)
                   (set! dp (make-vector (+ k 1) 0)))
                 (vector-ref prev k)))]))