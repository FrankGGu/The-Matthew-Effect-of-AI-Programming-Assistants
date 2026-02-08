#lang racket

(define (min-swaps-arrangement nums k)
  (define n (length nums))
  (define pos (filter (λ (i) (= (list-ref nums i) 1)) (range n)))
  (define len (length pos))
  (when (< len k) 0)
  (define (median-indexes i)
    (let ([mid (quotient k 2)])
      (+ i mid)))
  (define (swap-counts i)
    (let ([m (median-indexes i)])
      (for/sum ([j (in-range i (+ i k))])
        (- (list-ref pos j) (list-ref pos (+ i (quotient k 2)))))))
  (for/fold ([res +inf.0]) ([i (in-range 0 (- len k +1))])
    (min res (swap-counts i))))

(define (min-swaps nums k)
  (min-swaps-arrangement nums k))