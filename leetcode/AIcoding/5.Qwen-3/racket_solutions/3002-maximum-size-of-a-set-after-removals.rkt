#lang racket

(define/contract (maximum-size-of-a-set nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([freq (make-hash)]
         [n (length nums)]
         [count (lambda (x) (hash-ref freq x 0))]
         [max-size 0])
    (for-each (lambda (x) (hash-set! freq x (+ 1 (count x)))) nums)
    (let loop ([freqs (sort (hash-values freq) >)])
      (when (not (null? freqs))
        (let ([c (car freqs)])
          (set! max-size (+ max-size (min c 2)))
          (loop (cdr freqs)))))
    max-size))