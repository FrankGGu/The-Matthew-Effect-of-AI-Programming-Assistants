#lang racket

(define (make-iterator lst)
  (let ((index 0))
    (lambda ()
      (if (< index (length lst))
          (begin
            (set! index (+ index 1))
            (list-ref lst (- index 1)))
          #f))))

(define (data-stream-as-disjoint-intervals)
  (let ((intervals '()))
    (lambda (val)
      (set! intervals (sort (cons val intervals) (lambda (a b) (< (car a) (car b)))))
      (let loop ((i 0) (result '()))
        (if (>= i (length intervals))
            (reverse result)
            (let ((current (list-ref intervals i)))
              (if (null? result)
                  (loop (+ i 1) (list current))
                  (let ((last (car result)))
                    (if (<= (cadr last) (car current))
                        (loop (+ i 1) (cons (list (car last) (max (cadr last) (cadr current))) (cdr result)))
                        (loop (+ i 1) (cons current result)))))))))))

(define (main)
  (define ds (data-stream-as-disjoint-intervals))
  (define input (make-iterator '(1 3 5 7 2 4 6 8)))
  (define output '())
  (let loop ()
    (define val (input))
    (when val
      (set! output (append output (list (ds val))))
      (loop)))
  (display output))

(main)