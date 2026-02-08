#lang racket

(define (distinct-colors balls)
  (length (remove-duplicates balls)))