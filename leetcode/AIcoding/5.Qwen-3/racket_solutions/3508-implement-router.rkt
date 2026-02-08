#lang racket

(define (make-router)
  (let ([routes (hash)])
    (define (add-route path handler)
      (hash-set! routes path handler))
    (define (handle-request path)
      (if (hash-has-key? routes path)
          ((hash-ref routes path))
          #f))
    (lambda (msg . args)
      (cond
        [(eqv? msg 'add-route) (apply add-route args)]
        [(eqv? msg 'handle-request) (apply handle-request args)])))

(define (main)
  (define router (make-router))
  (router 'add-route "/home" (lambda () "Home Page"))
  (router 'add-route "/about" (lambda () "About Page"))
  (display (router 'handle-request "/home"))
  (newline)
  (display (router 'handle-request "/about"))
  (newline)
  (display (router 'handle-request "/contact"))
  (newline))

(main)