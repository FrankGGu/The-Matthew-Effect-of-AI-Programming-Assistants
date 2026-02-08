#lang racket

(define (delete-leaves root target)
  (cond
    [(null? root) #f]
    [(and (null? (left root)) (null? (right root)) (= (val root) target)) #t]
    [else
     (let ([left-removed? (delete-leaves (left root) target)]
           [right-removed? (delete-leaves (right root) target)])
       (when left-removed?
         (set-left! root #f))
       (when right-removed?
         (set-right! root #f))
       (and (null? (left root)) (null? (right root)) (= (val root) target)))]))

(define (main root target)
  (delete-leaves root target)
  root)