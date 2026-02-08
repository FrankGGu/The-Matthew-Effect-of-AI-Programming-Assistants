#lang racket

(define (number-of-valid-words sentence)
  (define (is-valid word)
    (and (not (regexp-match #px"\\d" word))
         (not (regexp-match #px"[!@#$%^&*()_+{}\":;'`|<>?~\\-]$" word))
         (not (regexp-match #px"\\s" word))))
  (length (filter is-valid (string-split sentence))))