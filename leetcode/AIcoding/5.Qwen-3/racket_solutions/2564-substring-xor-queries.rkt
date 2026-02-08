#lang racket

(define (substring-xor-queries s queries)
  (define n (string-length s))
  (define prefix (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix (+ i 1) (bitwise-xor (vector-ref prefix i) (char->integer (string-ref s i)))))
  (define (get-xor l r)
    (bitwise-xor (vector-ref prefix (+ r 1)) (vector-ref prefix l)))
  (for/list ([q queries])
    (let ([l (car q)] [r (cadr q)])
      (list l r (get-xor l r)))))