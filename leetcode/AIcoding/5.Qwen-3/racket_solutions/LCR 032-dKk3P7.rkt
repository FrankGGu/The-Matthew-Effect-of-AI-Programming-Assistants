#lang racket

(define (is-true? s t)
  (equal? (sort (string->list s) char<?) (sort (string->list t) char<?)))

(define/contract (valid-anagram s t)
  (-> string? string? boolean?)
  (is-true? s t))