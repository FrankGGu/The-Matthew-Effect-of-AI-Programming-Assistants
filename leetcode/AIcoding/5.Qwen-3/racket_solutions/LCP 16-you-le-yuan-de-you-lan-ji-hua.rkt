#lang racket

(define (min-cost-to-hire-buses n cost)
  (define (compare a b)
    (< (car a) (car b)))
  (define (sort-rides rides)
    (cond [(null? rides) '()]
          [else (let ([pivot (car rides)]
                      [rest (cdr rides)])
                  (append (sort-rides (filter (lambda (x) (compare x pivot)) rest))
                          (list pivot)
                          (sort-rides (filter (lambda (x) (not (compare x pivot))) rest)))]))
  (define (can-ride? ride1 ride2)
    (and (<= (car ride1) (car ride2))
         (>= (cadr ride1) (cadr ride2))))
  (define (get-min-cost rides)
    (if (null? rides)
        0
        (let ([current (car rides)])
          (+ (caddr current)
             (get-min-cost (filter (lambda (ride) (not (can-ride? current ride))) (cdr rides))))))
  (get-min-cost (sort-rides (map (lambda (i) (list i (add1 i) (list-ref cost i))) (range n))))