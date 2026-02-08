#lang racket

(define (max-subsequence-count s t)
  (define (count-occurrences str ch)
    (for/sum ([c str]) (if (= c ch) 1 0)))

  (define t-len (string-length t))
  (define t-first (string-ref t 0))
  (define t-last (string-ref t t-len))

  (define count-t-first (count-occurrences s t-first))
  (define count-t-last (count-occurrences s t-last))

  (if (or (= t-len 0) (= t-len 1))
      (if (= t-len 0) 0 count-t-first)
      (min count-t-first count-t-last)))