#lang racket

(define (make-fancy-sequence)
  (let ((seq '()))
    (lambda (cmd . args)
      (cond
        [(equal? cmd 'append) (set! seq (append seq (car args)))]
        [(equal? cmd 'addAll) (set! seq (map (lambda (x) (+ x (car args))) seq))]
        [(equal? cmd 'multAll) (set! seq (map (lambda (x) (* x (car args))) seq))]
        [(equal? cmd 'getIndex) (list-ref seq (car args))]))))