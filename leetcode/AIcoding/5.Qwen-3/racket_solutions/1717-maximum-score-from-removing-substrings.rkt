#lang racket

(define (maximum-score s p)
  (define (score s p)
    (let loop ([s s] [res 0])
      (if (string=? s "")
          res
          (let ([idx (string-contains s p)])
            (if (not idx)
                res
                (loop (string-take s idx) (+ res p)))))))

  (define (string-contains s sub)
    (let ([len (string-length sub)])
      (for/first ([i (in-range (- (string-length s) len -1))])
        (if (equal? (substring s i (+ i len)) sub) i #f))))

  (define (remove-substrings s)
    (let loop ([s s] [res 0])
      (if (string=? s "")
          res
          (let ([idx (string-contains s "a")])
            (if (not idx)
                res
                (loop (string-replace s (substring s idx (+ idx 1)) "") (+ res 10)))))))

  (max (score s 10) (score s 5)))

(define (main)
  (define input (read-line))
  (define p (string->number (read-line)))
  (display (maximum-score input p)))

(main)