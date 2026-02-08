#lang racket

(define/contract (find-words-containing-char words x)
  (-> (listof string?) char? (listof string?))
  (filter (lambda (word) (member x (string->list word))) words))