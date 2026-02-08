#lang racket

(define/contract (count-pairs nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define count 0)
  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1) n)])
      (when (= (modulo (+ (list-ref nums i) (list-ref nums j)) 24) 0)
        (set! count (+ count 1)))))
  count)