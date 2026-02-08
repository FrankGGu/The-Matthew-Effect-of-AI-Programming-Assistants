#lang racket

(define/contract (generate-string n)
  (-> exact-integer? string?)
  (if (= (remainder n 2) 0)
      (string-append (make-string (- n 1) #\a) "b")
      (make-string n #\a)))