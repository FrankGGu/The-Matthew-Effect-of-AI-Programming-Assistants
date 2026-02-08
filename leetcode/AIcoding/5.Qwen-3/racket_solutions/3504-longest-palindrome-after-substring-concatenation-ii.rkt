#lang racket

(define (longest-palindrome-after-substring-concatenation-ii s)
  (define n (string-length s))
  (define (is-palindrome? s)
    (equal? s (reverse (string->list s))))
  (define (helper i j)
    (if (>= i j)
        0
        (let ([s1 (substring s 0 i)]
              [s2 (substring s j n)])
          (if (is-palindrome? (string-append s1 s2))
              (- j i)
              (max (helper i (add1 j)) (helper (add1 i) j))))))
  (helper 0 n))