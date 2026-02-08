#lang racket

(define-struct person (name children))

(define (throne-inheritance king-name)
  (define king (make-person king-name '()))
  (define (add-child parent-name child-name)
    (let loop ([p king])
      (cond [(equal? (person-name p) parent-name) 
             (set-person-children! p (cons child-name (person-children p)))]
            [else
             (for-each loop (person-children p))])))
  (define (get-inheritance-order)
    (define result '())
    (define (traverse p)
      (set! result (cons (person-name p) result))
      (for-each traverse (person-children p)))
    (traverse king)
    (reverse result))
  (lambda (cmd . args)
    (cond [(equal? cmd 'add-child) (apply add-child args)]
          [(equal? cmd 'get-inheritance-order) (get-inheritance-order)])))