#lang racket

(define (number-of-flowers-in-full-bloom flowers people)
  (define starts (map first flowers))
  (define ends (map second flowers))
  (define sorted-starts (sort starts <))
  (define sorted-ends (sort ends <))
  (define (count-flowers time)
    (- (binary-search sorted-starts time) (binary-search sorted-ends time)))
  (map count-flowers people))

(define (binary-search lst x)
  (define (helper low high)
    (if (>= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (< (list-ref lst mid) x)
              (helper (+ mid 1) high)
              (helper low mid)))))
  (helper 0 (length lst)))