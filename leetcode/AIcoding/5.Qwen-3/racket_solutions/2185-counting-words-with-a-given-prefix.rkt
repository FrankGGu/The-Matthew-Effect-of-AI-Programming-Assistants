#lang racket

(define/contract (prefix-count words prefix)
  (-> (listof string?) string? exact-integer?)
  (length (filter (lambda (word) (string-prefix? prefix word)) words)))