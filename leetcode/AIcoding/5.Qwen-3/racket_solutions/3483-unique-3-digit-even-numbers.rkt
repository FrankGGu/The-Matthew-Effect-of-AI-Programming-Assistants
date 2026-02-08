#lang racket

(define (find-even-numbers)
  (define digits '(0 1 2 3 4 5 6 7 8 9))
  (define result '())
  (for ([i digits])
    (when (not (= i 0))
      (for ([j digits])
        (when (not (= j i))
          (for ([k digits])
            (when (and (not (= k i)) (not (= k j)) (= (modulo (+ (* i 100) (* j 10) k)) 2))
              (set! result (cons (+ (* i 100) (* j 10) k) result)))))))
  (length result))