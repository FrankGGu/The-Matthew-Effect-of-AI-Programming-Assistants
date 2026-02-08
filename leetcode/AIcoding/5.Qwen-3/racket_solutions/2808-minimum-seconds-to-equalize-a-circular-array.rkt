#lang racket

(define (minimum-seconds color-segments)
  (define (count-occurrences lst)
    (for/fold ([counts (hash)]) ([c lst])
      (hash-update counts c add1 0)))

  (define (get-min-time segments)
    (define freq (count-occurrences segments))
    (define max-count (apply max (hash-values freq)))
    (if (= max-count 1)
        (add1 (quotient (length segments) 2))
        (quotient (sub1 (length segments)) max-count)))

  (define (rotate-segment seg)
    (append (cdr seg) (list (car seg))))

  (define (min-time-for-rotation seg)
    (let loop ([current-seg seg] [time 0])
      (if (equal? current-seg (rotate-segment current-seg))
          time
          (loop (rotate-segment current-seg) (add1 time)))))

  (define (solve)
    (define n (length color-segments))
    (define min-time (for/fold ([min-t +inf.0]) ([i (in-range n)])
                       (min min-t (min-time-for-rotation (take color-segments i)))))
    min-time)

  (solve))