#lang racket

(define (make-lru-cache capacity)
  (let ((cache '()))
    (define (get key)
      (cond ((assoc key cache) => cadr)
            (else -1)))
    (define (put key value)
      (set! cache
        (cons (list key value)
              (filter (lambda (x) (not (= (car x) key))) cache)))
      (when (> (length cache) capacity)
        (set! cache (reverse (cdr (reverse cache))))))
    (lambda (op . args)
      (case op
        ((get) (apply get args))
        ((put) (apply put args)))))

(define (main)
  (let ((cache (make-lru-cache 2)))
    (display (cache 'get 1)) (newline)
    (cache 'put 1 1)
    (display (cache 'get 1)) (newline)
    (cache 'put 2 2)
    (display (cache 'get 2)) (newline)
    (cache 'put 3 3)
    (display (cache 'get 2)) (newline)
    (display (cache 'get 3)) (newline)))

(main)