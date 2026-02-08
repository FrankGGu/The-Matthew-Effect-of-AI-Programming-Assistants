#lang racket

(define (shortest-matching-substring s t)
  (define n (string-length s))
  (define m (string-length t))
  (define (match i j)
    (cond [(= j m) #t]
          [(= i n) #f]
          [else (and (= (string-ref s i) (string-ref t j))
                     (match (+ i 1) (+ j 1)))]))
  (define (helper i j)
    (if (>= i n)
        ""
        (if (match i j)
            (substring s i (+ i (- m j)))
            (helper (+ i 1) j))))
  (let loop ([i 0])
    (if (>= i n)
        ""
        (let ([res (helper i 0)])
          (if (not (equal? res ""))
              res
              (loop (+ i 1)))))))