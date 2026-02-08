#lang racket

(define (frequency s)
  (define c (string-ref s 0))
  (for/fold ([count 0]) ([ch (in-string s)])
    (if (= ch c) (+ count 1) count)))

(define (num-smaller-by-frequency q w)
  (define fq (frequency q))
  (define fw (frequency w))
  (if (< fq fw) 1 0))

(define (compare-strings-by-frequency queries words)
  (map (lambda (q) (apply + (map (lambda (w) (num-smaller-by-frequency q w)) words))) queries))