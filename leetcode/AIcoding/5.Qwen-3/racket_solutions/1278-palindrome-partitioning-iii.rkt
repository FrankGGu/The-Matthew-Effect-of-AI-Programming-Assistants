#lang racket

(define (solve s)
  (define n (string-length s))
  (define dp (make-vector n (make-vector n 0)))
  (for ([i (in-range n)])
    (vector-set! dp i i 0)
    (for ([j (in-range i (+ n 1))])
      (when (> j i)
        (vector-set! dp i j (+ (vector-ref dp i (- j 1)) (if (= (string-ref s i) (string-ref s j)) 0 1))))))

  (define memo (make-hash))
  (define (helper start)
    (hash-ref memo start (lambda ()
                           (if (= start n)
                               0
                               (let loop ([end start] [res +inf.0])
                                 (if (= end n)
                                     res
                                     (let ([cost (vector-ref dp start end)])
                                       (if (>= cost res)
                                           res
                                           (loop (+ end 1) (min res (+ cost (helper (+ end 1))))))))))))
  )
  (helper 0))