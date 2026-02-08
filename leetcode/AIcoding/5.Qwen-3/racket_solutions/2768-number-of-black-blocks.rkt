#lang racket

(define (count-black-blocks pieces)
  (define (add pos)
    (hash-update! cnt pos add1))

  (define (remove pos)
    (hash-update! cnt pos sub1))

  (define (get pos)
    (hash-ref cnt pos 0))

  (define cnt (make-hash))

  (for ([p pieces])
    (define x (car p))
    (define y (cadr p))
    (define dir (caddr p))
    (when (equal? dir 'down)
      (add (cons x y))
      (add (cons x (+ y 1)))
      (add (cons (+ x 1) y))
      (add (cons (+ x 1) (+ y 1))))
    (when (equal? dir 'right)
      (add (cons x y))
      (add (cons x (+ y 1)))
      (add (cons (+ x 1) y))
      (add (cons (+ x 1) (+ y 1)))))

  (define res 0)
  (for ([k (hash-keys cnt)])
    (when (= (hash-ref cnt k) 4)
      (set! res (+ res 1))))
  res)