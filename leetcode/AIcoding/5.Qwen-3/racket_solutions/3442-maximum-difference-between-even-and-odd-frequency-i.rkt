#lang racket

(define (module->list m)
  (let loop ([s (module-body m)] [acc '()])
    (if (null? s)
        acc
        (loop (cdr s) (cons (car s) acc)))))

(define (max-even-odd-frequency nums)
  (define freq (make-hash))
  (for-each (lambda (n)
              (hash-set! freq n (+ 1 (hash-ref freq n 0))))
            nums)
  (define even-freq 0)
  (define odd-freq 0)
  (for-each (lambda (k)
              (define cnt (hash-ref freq k))
              (if (even? cnt)
                  (set! even-freq (+ even-freq cnt))
                  (set! odd-freq (+ odd-freq cnt))))
            (hash-keys freq))
  (- even-freq odd-freq))