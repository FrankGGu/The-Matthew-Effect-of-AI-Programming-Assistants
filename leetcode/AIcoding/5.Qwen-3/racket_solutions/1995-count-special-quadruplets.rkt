#lang racket

(define (count-special-quadruplets nums)
  (define len (length nums))
  (define count 0)
  (for ([i (in-range len)])
    (for ([j (in-range (+ i 1) len)])
      (for ([k (in-range (+ j 1) len)])
        (for ([l (in-range (+ k 1) len)])
          (when (= (+ (list-ref nums i) (list-ref nums j))
                   (+ (list-ref nums k) (list-ref nums l)))
            (set! count (+ count 1))))))
  count)