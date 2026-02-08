#lang racket

(define (largest-rectangle-area heights)
  (define (area i j h)
    (* (- j i) h))
  (define (helper stack)
    (cond [(null? stack) 0]
          [else
           (let* ([top (car stack)]
                 [h (list-ref heights top)]
                 [left (if (null? (cdr stack)) -1 (car (cdr stack)))]
                 [current-area (area left top h)])
             (max current-area (helper (cdr stack))))]))
  (define (process stack i)
    (cond [(null? stack) (cons i stack)]
          [(<= (list-ref heights i) (list-ref heights (car stack)))
           (cons i stack)]
          [else
           (let ([new-stack (process (cdr stack) i)])
             (cons (car stack) new-stack))]))
  (define (loop i stack max-area)
    (if (= i (length heights))
        max-area
        (loop (+ i 1) (process stack i) (max max-area (helper (process stack i))))))
  (loop 0 '() 0))