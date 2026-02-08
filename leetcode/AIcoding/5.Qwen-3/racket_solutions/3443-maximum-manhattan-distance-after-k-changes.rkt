#lang racket

(define (max-manhattan-distance nums k)
  (define (manhattan a b) (abs (- a b)))
  (define (f s)
    (let loop ([i 0] [j (sub1 (length s))] [k k] [res 0])
      (cond [(>= i j) res]
            [(and (<= (manhattan (list-ref s i) (list-ref s j)) k) (< (manhattan (list-ref s i) (list-ref s j)) (manhattan (list-ref s i) (list-ref s j))))
             (loop (add1 i) (sub1 j) k res)]
            [else
             (let ([d (manhattan (list-ref s i) (list-ref s j))])
               (if (<= d k)
                   (loop (add1 i) (sub1 j) (- k d) (+ res d))
                   (loop (add1 i) (sub1 j) k res)))])))
  (f nums))