#lang racket

(define (get-size df)
  (list (length df) (length (car df))))