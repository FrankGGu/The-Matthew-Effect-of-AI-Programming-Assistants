#lang racket

(define/contract (asteroid-collision asteroids)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (collide left right)
    (cond
      [(> left (abs right)) (list left)]
      [(= left (abs right)) '()]
      [else (list right)]))
  (define (helper stack remaining)
    (cond
      [(null? remaining) stack]
      [else
       (let* ([current (car remaining)]
              [prev (if (null? stack) #f (last stack))])
         (if (and prev (> prev 0) (< current 0))
             (let ([collision (collide prev current)])
               (if (null? collision)
                   (helper (drop-last stack) (cons (last stack) (cdr remaining)))
                   (helper (append (drop-last stack) collision) (cdr remaining))))
             (helper (append stack (list current)) (cdr remaining))))]))
  (helper '() asteroids))