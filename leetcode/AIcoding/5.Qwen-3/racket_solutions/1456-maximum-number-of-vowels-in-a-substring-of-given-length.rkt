#lang racket

(define (max-vowels s k)
  (define vowels #(#\a #\e #\i #\o #\u))
  (define (is-vowel c)
    (member c vowels))
  (define len (string-length s))
  (define (count-vowels start end)
    (for/sum ([i (in-range start end)])
      (if (is-vowel (string-ref s i)) 1 0)))
  (define initial (count-vowels 0 k))
  (define (helper current max-count start)
    (if (>= start (- len k))
        max-count
        (let ([new-count (- current (if (is-vowel (string-ref s start)) 1 0))
              (next-char (string-ref s (+ start k)))]
          (helper (+ new-count (if (is-vowel next-char) 1 0))
                  (max max-count new-count)
                  (+ start 1)))))
  (helper initial initial 0))