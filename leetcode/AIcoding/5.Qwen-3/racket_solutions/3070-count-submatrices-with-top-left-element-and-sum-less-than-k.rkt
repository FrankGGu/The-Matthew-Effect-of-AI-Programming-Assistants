#lang racket

(define (count-submatrices-with-top-left-element-and-sum-less-than-k matrix k)
  (define rows (length matrix))
  (define cols (length (car matrix)))
  (define sum-2d (make-vector (* rows cols) 0))
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (vector-set! sum-2d (+ (* i cols) j) (vector-ref sum-2d (+ (* i cols) j))))) ; Initialize to 0
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (let ([current (list-ref (list-ref matrix i) j)])
        (if (= i 0)
            (vector-set! sum-2d (+ (* i cols) j) current)
            (vector-set! sum-2d (+ (* i cols) j) (+ current (vector-ref sum-2d (+ (* (- i 1) cols) j)))))
        (if (= j 0)
            (void)
            (vector-set! sum-2d (+ (* i cols) j) (+ (vector-ref sum-2d (+ (* i cols) j)) (vector-ref sum-2d (+ (* i cols) (- j 1))))))))
  (define count 0)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (for ([x (in-range i rows)])
        (for ([y (in-range j cols)])
          (let* ([top-left (vector-ref sum-2d (+ (* i cols) j))]
                 [bottom-right (vector-ref sum-2d (+ (* x cols) y))]
                 [sum (if (= i 0) (if (= j 0) bottom-right (- bottom-right top-left)) (- bottom-right top-left (vector-ref sum-2d (+ (* (- i 1) cols) y)) (if (= j 0) 0 (vector-ref sum-2d (+ (* x cols) (- j 1))))))])
            (when (< sum k)
              (set! count (+ count 1)))))))
  count)