#lang racket

(define (find-connection edges)
  (define parent (make-hash))
  (define (find x)
    (if (not (hash-has-key? parent x))
        x
        (let ([p (find (hash-ref parent x))])
          (hash-set! parent x p)
          p)))
  (define (union x y)
    (let ([xroot (find x)]
          [yroot (find y)])
      (if (equal? xroot yroot)
          #f
          (begin (hash-set! parent yroot xroot) #t))))
  (for/fold ([res '()])
            ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (if (union u v)
          res
          (cons edge res)))))

(define (main)
  (define input '((1 2) (1 3) (2 3)))
  (displayln (reverse (find-connection input))))

(main)