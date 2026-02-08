#lang racket

(define (count-beautiful-numbers)
  (define (is-beautiful? n)
    (define digits (string->list (number->string n)))
    (define even-count (length (filter (lambda (d) (= (modulo (string->number (list->string (list d))) 2) 0)) digits)))
    (define odd-count (length (filter (lambda (d) (= (modulo (string->number (list->string (list d))) 2) 1)) digits)))
    (= even-count odd-count))

  (define (count-beautiful up-to)
    (for/sum ([i (in-range 1 (add1 up-to))])
      (if (is-beautiful? i) 1 0)))

  (count-beautiful 1000000))