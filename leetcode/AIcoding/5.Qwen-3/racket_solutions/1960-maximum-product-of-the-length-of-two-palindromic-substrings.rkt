#lang racket

(define (max-palindromic-product s)
  (define n (string-length s))
  (define (expand l r)
    (let loop ([l l] [r r] [max-len 0])
      (if (and (>= l 0) (< r n) (= (string-ref s l) (string-ref s r)))
          (loop (sub1 l) (add1 r) (max max-len (- r l 1)))
          max-len)))
  (define pal-lengths
    (for/fold ([acc '()]) ([i (in-range n)])
      (append acc (list (max (expand i i) (expand i (add1 i)))))))
  (define (max-product lst)
    (if (< (length lst) 2)
        0
        (let* ([sorted (sort lst >)]
               [a (car sorted)]
               [b (cadr sorted)])
          (* a b))))
  (max-product pal-lengths))