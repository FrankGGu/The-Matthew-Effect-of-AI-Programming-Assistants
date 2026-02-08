#lang racket

(define (number-of-beautiful-integers n k)
  (define (is-beautiful? num)
    (define digits (string->list (number->string num)))
    (define len (length digits))
    (if (even? len)
        (let loop ([i 0] [sum 0])
          (cond [(= i len) (= sum 0)]
                [(even? i) (loop (+ i 1) (+ sum (string->number (list->string (list-ref digits i)))))]
                [else (loop (+ i 1) (- sum (string->number (list->string (list-ref digits i)))))]))
        #f))

  (define (count-beautiful start end)
    (for/sum ([i (in-range start (add1 end))])
      (if (is-beautiful? i) 1 0)))

  (count-beautiful 1 n))