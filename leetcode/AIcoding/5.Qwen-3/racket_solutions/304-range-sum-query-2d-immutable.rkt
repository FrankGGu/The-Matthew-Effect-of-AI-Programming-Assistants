#lang racket

(define (make-rangesumquery2d matrix)
  (let* ([rows (length matrix)]
         [cols (if (> rows 0) (length (car matrix)) 0)]
         [prefix (make-vector rows (make-vector cols 0))])
    (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (vector-set! (vector-ref prefix i) j
          (+ (vector-ref (vector-ref prefix i) j)
             (if (> i 0) (vector-ref (vector-ref prefix (- i 1)) j) 0)
             (if (> j 0) (vector-ref (vector-ref prefix i) (- j 1)) 0)
             (if (and (> i 0) (> j 0))
                 (- (vector-ref (vector-ref prefix (- i 1)) (- j 1))) 0)))))
    (lambda (row1 col1 row2 col2)
      (let ([sum (vector-ref (vector-ref prefix row2) col2)]
            [sum-up (if (> row1 0) (vector-ref (vector-ref prefix (- row1 1)) col2) 0)]
            [sum-left (if (> col1 0) (vector-ref (vector-ref prefix row2) (- col1 1)) 0)]
            [sum-diag (if (and (> row1 0) (> col1 0))
                          (vector-ref (vector-ref prefix (- row1 1)) (- col1 1))
                          0)])
        (- (+ sum sum-diag) (+ sum-up sum-left)))))))

(define (range-sum-query-2d matrix)
  (define rows (length matrix))
  (define cols (if (> rows 0) (length (car matrix)) 0))
  (define prefix (make-vector rows (make-vector cols 0)))
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (vector-set! (vector-ref prefix i) j
        (+ (vector-ref (vector-ref prefix i) j)
           (if (> i 0) (vector-ref (vector-ref prefix (- i 1)) j) 0)
           (if (> j 0) (vector-ref (vector-ref prefix i) (- j 1)) 0)
           (if (and (> i 0) (> j 0))
               (- (vector-ref (vector-ref prefix (- i 1)) (- j 1))) 0))))
  (lambda (row1 col1 row2 col2)
    (let ([sum (vector-ref (vector-ref prefix row2) col2)]
          [sum-up (if (> row1 0) (vector-ref (vector-ref prefix (- row1 1)) col2) 0)]
          [sum-left (if (> col1 0) (vector-ref (vector-ref prefix row2) (- col1 1)) 0)]
          [sum-diag (if (and (> row1 0) (> col1 0))
                        (vector-ref (vector-ref prefix (- row1 1)) (- col1 1))
                        0)])
      (- (+ sum sum-diag) (+ sum-up sum-left)))))

(define (main)
  (define matrix (list (list 3 0 1) (list 1 4 2) (list 5 6 7)))
  (define q (range-sum-query-2d matrix))
  (q 0 0 2 2))

(main)