#lang racket

(define (make-peeking-iterator iter)
  (define data (if (null? iter) '() (car iter)))
  (define index 0)
  (define (has-next)
    (< index (length data)))
  (define (next)
    (let ([val (list-ref data index)])
      (set! index (+ index 1))
      val))
  (define (peek)
    (list-ref data index))
  (lambda (msg . args)
    (cond
      [(eq? msg 'has-next) (has-next)]
      [(eq? msg 'next) (next)]
      [(eq? msg 'peek) (peek)])))