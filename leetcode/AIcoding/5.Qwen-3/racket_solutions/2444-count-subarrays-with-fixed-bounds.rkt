#lang racket

(define (count-subarrays nums k)
  (define (count-less-or-equal x)
    (let loop ([i 0] [j 0] [count 0] [sum 0])
      (cond [(= i (length nums)) count]
            [(<= sum x)
             (loop i (+ j 1) (+ count (- j i)) (+ sum (list-ref nums j)))]
            [else
             (loop (+ i 1) j (- count (- j i)) (- sum (list-ref nums i)))])))
  (let ([less-or-equal (count-less-or-equal k)])
    (- less-or-equal (count-less-or-equal (- k 1)))))