#lang racket

(define (lexicographically-smallest-equivalent-string input s)
  (define parent (make-hash))
  (define (find x)
    (unless (hash-has-key? parent x)
      (hash-set! parent x x))
    (if (equal? (hash-ref parent x) x)
        x
        (let ([p (find (hash-ref parent x))])
          (hash-set! parent x p)
          p)))
  (define (union x y)
    (let ([x-root (find x)]
          [y-root (find y)])
      (when (not (equal? x-root y-root))
        (if (char<? x-root y-root)
            (hash-set! parent y-root x-root)
            (hash-set! parent x-root y-root)))))
  (for-each (lambda (a b) (union a b)) (string->list input) (string->list s))
  (list->string (map (lambda (c) (find c)) (string->list s))))