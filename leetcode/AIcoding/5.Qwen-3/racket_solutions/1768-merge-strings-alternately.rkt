#lang racket

(define (merge-alternately word1 word2)
  (define (helper i j res)
    (cond [(and (= i (string-length word1)) (= j (string-length word2))) res]
          [(= i (string-length word1)) (string-append res (substring word2 j))]
          [(= j (string-length word2)) (string-append res (substring word1 i))]
          [else (helper (+ i 1) (+ j 1) (string-append res (string-ref word1 i) (string-ref word2 j)))]))
  (helper 0 0 ""))