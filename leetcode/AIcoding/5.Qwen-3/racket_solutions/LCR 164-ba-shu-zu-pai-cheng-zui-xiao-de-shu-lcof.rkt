#lang racket

(define (is-possible s target)
  (define len (string-length s))
  (define target-len (string-length target))
  (cond [(> target-len len) #f]
        [(= target-len len) (equal? s target)]
        [else
         (let loop ([i 0] [j 0])
           (cond [(>= i len) #f]
                 [(and (= j target-len) (< i len)) #t]
                 [(and (= j target-len) (= i len)) #t]
                 [(char=? (string-ref s i) (string-ref target j))
                  (loop (+ i 1) (+ j 1))]
                 [else (loop (+ i 1) j)]))]))

(define (solve)
  (define s (read-line))
  (define target (read-line))
  (if (is-possible s target) "YES" "NO"))

(solve)