#lang racket

(define (closest-divisors nums)
  (define (find-closest n)
    (let loop ([i (sqrt n)])
      (if (<= i 0)
          (cons n n)
          (if (= (modulo n i) 0)
              (cons i (/ n i))
              (loop (- i 1))))))
  (let* ([a (find-closest nums)]
         [b (find-closest (+ nums 1))]
         [diff-a (- (cdr a) (car a))]
         [diff-b (- (cdr b) (car b))])
    (if (<= diff-a diff-b)
        (list (car a) (cdr a))
        (list (car b) (cdr b)))))