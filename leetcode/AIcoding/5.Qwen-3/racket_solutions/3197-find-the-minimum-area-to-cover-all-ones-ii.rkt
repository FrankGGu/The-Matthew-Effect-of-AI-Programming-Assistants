#lang racket

(define (minimum-rectangle-area grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define-values (min-row max-row min-col max-col)
    (for/fold ([min-row +inf.0] [max-row -inf.0] [min-col +inf.0] [max-col -inf.0])
               ([i (in-range rows)]
                [row (in-list grid)])
      (for/fold ([min-row min-row] [max-row max-row] [min-col min-col] [max-col max-col])
                ([j (in-range cols)]
                 [val (in-list row)])
        (when (= val 1)
          (values (min min-row i) (max max-row i) (min min-col j) (max max-col j))))))
  (if (or (>= min-row max-row) (>= min-col max-col))
      0
      (* (- max-row min-row 1) (- max-col min-col 1))))

(define (main)
  (define input (read))
  (displayln (minimum-rectangle-area input)))

(main)