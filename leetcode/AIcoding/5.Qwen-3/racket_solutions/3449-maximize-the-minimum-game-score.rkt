#lang racket

(define (compare a b)
  (- (car b) (car a)))

(define (maximize-minimum-game-score nums)
  (define sorted-nums (sort nums compare))
  (define n (length nums))
  (define (helper i j)
    (if (>= i j)
        (list-ref sorted-nums i)
        (let* ([mid (quotient (+ i j) 2)]
               [left (helper i mid)]
               [right (helper (add1 mid) j)])
          (if (< left right)
              left
              right))))
  (helper 0 (sub1 n)))