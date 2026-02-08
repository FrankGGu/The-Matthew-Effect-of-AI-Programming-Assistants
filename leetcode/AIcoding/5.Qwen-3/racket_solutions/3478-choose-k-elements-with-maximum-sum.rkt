#lang racket

(define/contract (k-max-nums nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (take (sort nums >) k))