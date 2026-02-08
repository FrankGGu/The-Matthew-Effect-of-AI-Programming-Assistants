#lang racket

(define (count-integers-in-intervals)
  (define intervals (box '()))
  (define (add x)
    (set-box! intervals (sort (cons x (unbox intervals)) (lambda (a b) (< (car a) (car b))))))
  (define (count)
    (let loop ([intervals (unbox intervals)] [total 0])
      (if (null? intervals)
          total
          (loop (cdr intervals) (+ total (- (cadr (car intervals)) (car (car intervals)) 1))))))
  (lambda (op . args)
    (cond [(equal? op 'add) (add (car args))]
          [(equal? op 'count) (count)])))