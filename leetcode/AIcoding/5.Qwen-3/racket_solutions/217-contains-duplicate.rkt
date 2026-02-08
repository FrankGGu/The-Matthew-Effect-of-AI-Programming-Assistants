#lang racket

(define/contract (contains-duplicate nums)
  (-> (listof exact-integer?) boolean?)
  (not (= (length nums) (length (remove-duplicates nums)))))