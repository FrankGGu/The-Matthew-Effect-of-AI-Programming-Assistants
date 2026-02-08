#lang racket

(define (reverse-words s)
  (define (reverse-word word)
    (list->string (reverse (string->list word))))
  (define words (string-split s))
  (string-join (map reverse-word words) " "))