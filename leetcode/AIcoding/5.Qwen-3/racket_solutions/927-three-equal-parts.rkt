#lang racket

(define (three-equal-parts A)
  (define (count-ones lst)
    (foldl + 0 lst))

  (define ones (count-ones A))

  (cond [(= ones 0) '(0 0)]
        [(= (remainder ones 3) 0)
         (let* ([each (/ ones 3)]
                [first (index-of A 1)]
                [second (index-of (drop A (add1 first)) 1)]
                [third (index-of (drop A (+ first second 2)) 1)])
           (if (and (not (eqv? second #f)) (not (eqv? third #f)))
               (list (add1 first) (+ first second 2))
               '(0 0)))]
        [else '(0 0)]))

(define (index-of lst val)
  (define (helper lst i)
    (cond [(null? lst) #f]
          [(= (car lst) val) i]
          [else (helper (cdr lst) (add1 i))]))
  (helper lst 0))