#lang racket

(define (longest-alternating-subarray nums)
  (define n (length nums))
  (define max-len 1)
  (define current-len 1)
  (for ([i (in-range 1 n)])
    (when (not (= (list-ref nums (sub1 i)) (list-ref nums i)))
      (set! current-len (+ current-len 1))
      (when (> current-len max-len)
        (set! max-len current-len)))
    (when (= (list-ref nums (sub1 i)) (list-ref nums i))
      (set! current-len 1)))
  max-len)