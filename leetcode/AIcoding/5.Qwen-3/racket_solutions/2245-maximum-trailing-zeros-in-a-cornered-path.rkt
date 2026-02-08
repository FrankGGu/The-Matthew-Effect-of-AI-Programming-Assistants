#lang racket

(define (max-trailing-zeros grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define-values (row-0 row-1 row-2 row-3)
    (let ([dp (make-vector rows (make-vector cols 0))])
      (for ([i (in-range rows)])
        (for ([j (in-range cols)])
          (vector-set! (vector-ref dp i) j
                       (if (zero? i)
                           (if (zero? j)
                               (vector-ref (vector-ref grid i) j)
                               (vector-ref (vector-ref grid i) j))
                           (if (zero? j)
                               (vector-ref (vector-ref grid i) j)
                               (vector-ref (vector-ref grid i) j)))))
      (values dp dp dp dp)))

  (define (count-trailing-zeros n)
    (if (zero? n) 0
        (let loop ([n n] [count 0])
          (if (= (modulo n 10) 0)
              (loop (quotient n 10) (+ count 1))
              count))))

  (define (max-corner i j)
    (let ([val (vector-ref (vector-ref grid i) j)])
      (let ([up (vector-ref (vector-ref row-0 i) j)]
            [down (vector-ref (vector-ref row-1 i) j)]
            [left (vector-ref (vector-ref row-2 i) j)]
            [right (vector-ref (vector-ref row-3 i) j)])
        (max (count-trailing-zeros (+ up left))
             (count-trailing-zeros (+ up right))
             (count-trailing-zeros (+ down left))
             (count-trailing-zeros (+ down right))))))

  (define max-zeros 0)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (set! max-zeros (max max-zeros (max-corner i j))))
    max-zeros))