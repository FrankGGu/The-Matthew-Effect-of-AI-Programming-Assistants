#lang racket

(define (count-ways-to-group-overlapping-ranges ranges)
  (define (sort-ranges ranges)
    (sort ranges (lambda (a b) (< (car a) (car b)))))

  (define sorted-ranges (sort-ranges ranges))

  (define (merge-ranges ranges)
    (cond [(null? ranges) '()]
          [else
           (let loop ([current (car ranges)]
                      [remaining (cdr ranges)]
                      [result '()])
             (if (null? remaining)
                 (cons current result)
                 (let ([next (car remaining)])
                   (if (<= (cadr current) (car next))
                       (loop (list (car current) (max (cadr current) (cadr next)))
                             (cdr remaining)
                             result)
                       (loop next (cdr remaining) (cons current result))))))]))

  (define merged (merge-ranges sorted-ranges))

  (define (count-ways merged)
    (if (null? merged)
        1
        (let ([n (length merged)])
          (expt 2 (sub1 n)))))

  (count-ways merged))