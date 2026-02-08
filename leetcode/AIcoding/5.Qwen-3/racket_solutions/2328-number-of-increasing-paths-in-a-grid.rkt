#lang racket

(define (num-increasing-paths grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define dp (make-vector rows (make-vector cols 0)))
  (define memo (make-hash))

  (define (dfs r c)
    (cond [(hash-has-key? memo (cons r c)) (hash-ref memo (cons r c))]
          [else
           (define res 1)
           (for-each (lambda (dr dc)
                       (when (and (< 0 dr) (< 0 dc) (< dr rows) (< dc cols))
                         (when (< (vector-ref (vector-ref grid r) c) (vector-ref (vector-ref grid (- r dr) (- c dc))))
                           (set! res (+ res (dfs (- r dr) (- c dc)))))))
                     '((1 0) (-1 0) (0 1) (0 -1)))
           (hash-set! memo (cons r c) res)
           res]))

  (for*/sum ([r (in-range rows)]
             [c (in-range cols)])
    (dfs r c)))