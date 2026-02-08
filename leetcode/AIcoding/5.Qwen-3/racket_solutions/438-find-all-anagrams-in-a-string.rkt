#lang racket

(define (find-anagrams s p)
  (define len-s (string-length s))
  (define len-p (string-length p))
  (cond [(> len-p len-s) '()]
        [else
         (define target-count (make-hash))
         (for ([c p])
           (hash-update! target-count c add1 0))
         (define current-count (make-hash))
         (for ([i (in-range len-p)])
           (hash-update! current-count (string-ref s i) add1 0))
         (define result '())
         (when (= (hash->list target-count) (hash->list current-count))
           (set! result (cons 0 result)))
         (for ([i (in-range len-p len-s)])
           (hash-update! current-count (string-ref s (- i len-p)) sub1)
           (when (= (hash-ref current-count (string-ref s (- i len-p)) 0) 0)
             (hash-remove! current-count (string-ref s (- i len-p))))
           (hash-update! current-count (string-ref s i) add1 0)
           (when (= (hash->list target-count) (hash->list current-count))
             (set! result (cons (- i len-p 1) result))))
         (reverse result)]))