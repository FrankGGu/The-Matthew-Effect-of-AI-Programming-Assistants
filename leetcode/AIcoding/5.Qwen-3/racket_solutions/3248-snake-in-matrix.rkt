#lang racket

(define (snake-in-matrix matrix)
  (define rows (length matrix))
  (define cols (if (> rows 0) (length (car matrix)) 0))
  (define result '())
  (for ([i (in-range rows)])
    (if (even? i)
        (set! result (append result (list-ref matrix i)))
        (set! result (append result (reverse (list-ref matrix i))))))
  result)