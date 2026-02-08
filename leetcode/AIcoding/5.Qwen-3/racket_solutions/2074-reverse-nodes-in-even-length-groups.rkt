#lang racket

(define (reverse-nodes-in-even-length-groups head)
  (define (reverse-list head end)
    (define (iter prev curr)
      (if (eqv? curr end)
          prev
          (let ((next (cdr curr)))
            (set-cdr! curr prev)
            (iter curr next))))
    (iter #f head))

  (define (get-length head k)
    (let loop ([node head] [count 0])
      (if (or (null? node) (= count k))
          count
          (loop (cdr node) (+ count 1)))))

  (define (reverse-in-groups head)
    (let loop ([current head] [group 1])
      (if (null? current)
          head
          (let* ([length (get-length current 2)]
                 [next (if (= (modulo length 2) 0)
                           (let ([next (list-tail current length)])
                             (reverse-list current next)
                             next)
                           (begin
                             (set-cdr! current (reverse-in-groups (cdr current)))
                             #f))])
            (if next
                (loop next (+ group 1))
                head)))))

  (reverse-in-groups head))