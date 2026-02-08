#lang racket

(define (find-min-fibonacci-numbers k)
  (define (generate-fibs n)
    (let loop ([a 1] [b 1] [fibs (list 1 1)])
      (if (> (+ a b) n)
          (reverse fibs)
          (loop b (+ a b) (cons (+ a b) fibs)))))

  (define fibs (generate-fibs k))
  (define (helper remaining res)
    (if (zero? remaining)
        res
        (let ([f (car (filter (lambda (x) (<= x remaining)) fibs))])
          (helper (- remaining f) (+ res 1)))))

  (helper k 0))