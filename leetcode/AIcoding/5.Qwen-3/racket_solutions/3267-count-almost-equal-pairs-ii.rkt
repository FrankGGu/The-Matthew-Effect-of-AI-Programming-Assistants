#lang racket

(define (count-almost-equal-pairs nums)
  (define (count-operations a b)
    (define (helper x y res)
      (if (= x y)
          res
          (helper (quotient x 10) (quotient y 10) (+ res 1))))
    (helper a b 0))

  (define (is-almost-equal a b)
    (<= (count-operations a b) 2))

  (define (helper lst res)
    (cond [(null? lst) res]
          [else
           (helper (cdr lst)
                   (+ res
                      (length
                       (filter (lambda (x) (is-almost-equal (car lst) x))
                               (cdr lst)))))]))

  (helper nums 0))