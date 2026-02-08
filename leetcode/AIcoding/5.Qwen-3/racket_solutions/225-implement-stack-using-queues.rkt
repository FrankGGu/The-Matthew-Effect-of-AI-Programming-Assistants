#lang racket

(define-struct queue (elements)
  #:mutable)

(define (make-queue) (queue '()))

(define (enqueue q x) (set-queue-elements! q (append (queue-elements q) (list x))))

(define (dequeue q) 
  (let ((x (car (queue-elements q))))
    (set-queue-elements! q (cdr (queue-elements q)))
    x))

(define (empty? q) (null? (queue-elements q)))

(define-struct stack ()
  #:mutable)

(define (make-stack) (stack))

(define (push s x)
  (define q (make-queue))
  (enqueue q x)
  (set-stack-elements! s (list q)))

(define (pop s)
  (define q (car (stack-elements s)))
  (dequeue q))

(define (top s)
  (define q (car (stack-elements s)))
  (car (queue-elements q)))

(define (empty s)
  (empty? (car (stack-elements s))))