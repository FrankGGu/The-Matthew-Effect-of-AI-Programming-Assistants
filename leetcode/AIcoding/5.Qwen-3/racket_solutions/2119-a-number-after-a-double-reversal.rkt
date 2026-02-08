#lang racket

(define (number-after-reversal num)
  (define (reverse-number n)
    (string->number (list->string (reverse (string->list (number->string n))))))
  (reverse-number (reverse-number num)))