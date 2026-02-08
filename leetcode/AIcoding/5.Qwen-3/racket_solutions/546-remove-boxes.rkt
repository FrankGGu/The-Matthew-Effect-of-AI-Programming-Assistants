#lang racket

(define (remove-boxes boxes)
  (define memo (make-hash))
  (define (dp l r k)
    (cond [(> l r) 0]
          [(hash-has-key? memo (cons l (cons r (cons k '())))) (hash-ref memo (cons l (cons r (cons k '()))))]
          [else
           (let ([res (if (= (list-ref boxes l) (list-ref boxes r))
                         (dp l (sub1 r) (add1 k))
                         (dp l (sub1 r) 0))])
             (for/fold ([max-res res]) ([i (in-range l r)])
               (if (= (list-ref boxes i) (list-ref boxes r))
                   (max max-res (+ (dp l i 0) (dp (add1 i) (sub1 r) (add1 k))))
                   max-res)))
             (hash-set! memo (cons l (cons r (cons k '()))) res)
             res)]))
  (dp 0 (sub1 (length boxes)) 0))