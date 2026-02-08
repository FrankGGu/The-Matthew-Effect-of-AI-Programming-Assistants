#lang racket

(define (palindrome? s)
  (equal? s (reverse s)))

(define (max-palindrome-product s)
  (define len (string-length s))
  (define n len)
  (define max-prod 0)
  (define (generate-subsequences i path)
    (when (<= i n)
      (when (and (not (null? path)) (palindrome? path))
        (set! max-prod (max max-prod (* (length path) (length (filter palindrome? (map (lambda (x) (substring s 0 x)) (range 0 n)))))))
      (when (< i n)
        (generate-subsequences (+ i 1) (append path (list (string-ref s i))))
        (generate-subsequences (+ i 1) path))))
  (generate-subsequences 0 '())
  max-prod)

(define (main)
  (define input (read-line))
  (printf "~a\n" (max-palindrome-product input)))

(main)