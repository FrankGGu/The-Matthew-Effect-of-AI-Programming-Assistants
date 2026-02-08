#lang racket

(define/contract (check-arrangement s)
  (-> string? boolean?)
  (let loop ([s s] [a-found #f])
    (cond [(string=? s "") #t]
          [(char=? (string-ref s 0) #\a) (loop (substring s 1) #t)]
          [(and a-found (char=? (string-ref s 0) #\b)) (loop (substring s 1) #t)]
          [else #f])))