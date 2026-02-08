#lang racket

(define (minimum-pushes word)
  (define freq (make-hash))
  (for-each (lambda (c) (hash-set! freq c (+ 1 (hash-ref freq c 0)))) (string->list word))
  (define sorted-freq (sort (hash->list freq) (lambda (a b) (> (cdr a) (cdr b)))))
  (define keys (make-vector 8 0))
  (let loop ([i 0] [sorted-freq sorted-freq])
    (cond
      [(null? sorted-freq) 0]
      [else
       (let ([char (caar sorted-freq)]
             [count (cdar sorted-freq)])
         (vector-set! keys i (add1 (vector-ref keys i)))
         (+ (* count (add1 (vector-ref keys i))) (loop (modulo (add1 i) 8) (cdr sorted-freq))))])))

(define (main)
  (define input (read-line))
  (display (minimum-pushes input)))

(main)