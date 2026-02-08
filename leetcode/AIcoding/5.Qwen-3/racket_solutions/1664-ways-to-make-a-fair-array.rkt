#lang racket

(define (is-fair? arr i)
  (define left-sum (for/sum ([j (in-range 0 i)]) (list-ref arr j)))
  (define right-sum (for/sum ([j (in-range (add1 i) (length arr))]) (list-ref arr j)))
  (= left-sum right-sum))

(define (num-of-ways arr)
  (define n (length arr))
  (for/sum ([i (in-range n)] #:when (is-fair? arr i)) 1))

(define (main)
  (define input (read))
  (displayln (num-of-ways input)))

(main)