#lang racket

(define (are-equivalent s t)
  (define (count-chars str)
    (for/fold ([counts (hash)]) ([c (in-string str)])
      (hash-update counts c add1 0)))
  (define s-count (count-chars s))
  (define t-count (count-chars t))
  (if (not (equal? (hash-keys s-count) (hash-keys t-count)))
      #f
      (let loop ([i 0] [diff 0])
        (cond [(= i (string-length s)) (= diff 2)]
              [(char=? (string-ref s i) (string-ref t i)) (loop (+ i 1) diff)]
              [else (loop (+ i 1) (+ diff 1))]))))

(define (areAlmostEqual s t)
  (and (= (string-length s) (string-length t))
       (are-equivalent s t)))