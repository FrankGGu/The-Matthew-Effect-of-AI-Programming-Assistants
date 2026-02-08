#lang racket

(define (array-strings-equal word1 word2)
  (equal? (string-join word1) (string-join word2)))