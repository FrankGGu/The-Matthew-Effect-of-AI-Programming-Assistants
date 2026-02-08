#lang racket

(define (make-connected n connections)
  (define parent (make-vector n))
  (define (find x)
    (if (= (vector-ref parent x) x)
        x
        (let ([p (find (vector-ref parent x))])
          (vector-set! parent x p)
          p)))
  (define (union x y)
    (let ([xroot (find x)]
          [yroot (find y)])
      (when (not (= xroot yroot))
        (vector-set! parent yroot xroot)
        #t)))
  (for ([i (in-range n)])
    (vector-set! parent i i))
  (for ([c connections])
    (union (car c) (cadr c)))
  (define roots (set))
  (for ([i (in-range n)])
    (set-add! roots (find i)))
  (- (set-count roots) 1))