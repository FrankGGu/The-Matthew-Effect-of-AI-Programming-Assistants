#lang racket

(define/contract (sum-encrypted-int s)
  (-> string? exact-integer?)
  (define (transform n)
    (let loop ([n n] [res 0])
      (if (= n 0)
          res
          (loop (quotient n 10) (+ res (remainder n 10))))))
  (define (count-chars s)
    (for/sum ([c s])
      (let ([d (- (char->integer c) (char->integer #\0))])
        (if (= d 0) 1 (add1 (floor (log (expt 10 d) 10)))))))
  (count-chars s))