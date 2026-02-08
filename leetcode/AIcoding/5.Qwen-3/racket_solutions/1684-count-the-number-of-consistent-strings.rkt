#lang racket

(define (count-consistent-strings allowed word)
  (define allowed-set (list->set allowed))
  (define (is-consistent? w)
    (andmap (λ (c) (set-member? allowed-set c)) w))
  (length (filter is-consistent? word)))