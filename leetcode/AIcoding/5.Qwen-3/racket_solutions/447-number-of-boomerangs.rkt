#lang racket

(define (num-boomerangs points)
  (define (count p)
    (define (helper q acc)
      (if (null? q)
          acc
          (let* ([dx (- (car p) (caar q))]
                 [dy (- (cadr p) (cadar q))]
                 [key (cons dx dy)])
            (helper (cdr q) (hash-update acc key add1 0)))))
    (helper (cdr points) (make-hash)))
  (define (add1 x) (+ x 1))
  (define (sum-hashes h)
    (for/sum ([v (in-hash-values h)]) (* v (- v 1))))
  (for/sum ([p points]) (sum-hashes (count p))))