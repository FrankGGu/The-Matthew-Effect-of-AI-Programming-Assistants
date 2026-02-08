#lang racket

(define (largest-rectangle-heights heights)
  (define (helper stack i)
    (if (= i (length heights))
        (let loop ((stack stack) (max-area 0))
          (if (null? stack)
              max-area
              (let* ((h (list-ref heights (car stack)))
                     (w (if (null? (cdr stack)) i (- i (cadr stack) 1)))
                     (area (* h w)))
                (loop (cdr stack) (max max-area area)))))
        (let ((current (list-ref heights i)))
          (if (or (null? stack) (<= current (list-ref heights (car stack))))
              (helper (cons i stack) (+ i 1))
              (let ((top (car stack)))
                (helper (cdr stack) i)))))
  (helper '() 0))

(define/contract (largest-rectangle-in-histogram heights)
  (-> (listof exact-integer?) exact-integer?)
  (largest-rectangle-heights heights))