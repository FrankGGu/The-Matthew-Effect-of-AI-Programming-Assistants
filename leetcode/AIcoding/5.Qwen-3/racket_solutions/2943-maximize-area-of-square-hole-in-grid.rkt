#lang racket

(define (maximize-area grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define dp (make-vector rows (make-vector cols 0)))
  (define max-area 0)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (cond
        [(or (= i 0) (= j 0) (not (equal? (list-ref (list-ref grid i) j) "1"))) (vector-set! (vector-ref dp i) j 0)]
        [else
         (vector-set! (vector-ref dp i) j (+ 1 (min (vector-ref (vector-ref dp (- i 1) ) j)
                                                   (vector-ref (vector-ref dp i (- j 1)) )
                                                   (vector-ref (vector-ref dp (- i 1) (- j 1)) ))))]
         (set! max-area (max max-area (vector-ref (vector-ref dp i) j)))]))
  (* max-area max-area))