#lang racket

(define (is-scramble s1 s2)
  (define (helper s1 s2 memo)
    (cond [(equal? s1 s2) #t]
          [(not (= (string-length s1) (string-length s2))) #f]
          [(hash-has-key? memo (cons s1 s2)) (hash-ref memo (cons s1 s2))]
          [else
           (let ([n (string-length s1)]
                 [result #f])
             (for ([i (in-range 1 n)])
               (when (and (helper (substring s1 0 i) (substring s2 0 i) memo)
                          (helper (substring s1 i) (substring s2 i) memo))
                 (set! result #t)))
             (for ([i (in-range 1 n)])
               (when (and (helper (substring s1 0 i) (substring s2 (- n i)) memo)
                          (helper (substring s1 i) (substring s2 0 (- n i)) memo))
                 (set! result #t)))
             (hash-set! memo (cons s1 s2) result)
             result)]))
  (helper s1 s2 (make-hash)))