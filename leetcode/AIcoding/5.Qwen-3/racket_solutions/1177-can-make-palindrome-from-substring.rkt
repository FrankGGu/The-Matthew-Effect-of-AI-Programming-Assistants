#lang racket

(define (can-make-palindrome s queries)
  (define (count-odd freq)
    (for/sum ([c (in-vector freq)]) (if (odd? c) 1 0)))

  (define (build-freq)
    (let ([freq (make-vector 26 0)])
      (for ([ch (in-string s)])
        (vector-set! freq (- (char->integer ch) 97) (+ 1 (vector-ref freq (- (char->integer ch) 97)))))
      freq))

  (define freq (build-freq))

  (define (query l r)
    (let ([cnt (count-odd (vector-copy freq))])
      (if (<= cnt 1) #t #f)))

  (map query queries))