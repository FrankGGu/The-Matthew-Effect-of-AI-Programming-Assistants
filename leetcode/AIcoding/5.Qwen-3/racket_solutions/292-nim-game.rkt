#lang racket

(define (can-win-nim n)
  (not (= (modulo n 4) 0)))