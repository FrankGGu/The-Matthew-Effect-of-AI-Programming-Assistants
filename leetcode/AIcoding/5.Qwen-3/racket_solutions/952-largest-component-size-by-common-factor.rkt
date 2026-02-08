#lang racket

(define (largest-component-size nums)
  (define (find parent x)
    (if (= parent x)
        x
        (find parent (vector-ref parent x))))

  (define (union parent rank x y)
    (define root-x (find parent x))
    (define root-y (find parent y))
    (when (= root-x root-y)
      (void))
    (when (< rank root-x)
      (vector-set! parent root-y root-x))
    (when (< rank root-y)
      (vector-set! parent root-x root-y))
    (when (= rank root-x)
      (vector-set! parent root-y root-x)
      (vector-set! rank root-x (+ (vector-ref rank root-x) 1))))

  (define max-num (apply max nums))
  (define parent (make-vector (add1 max-num) 0))
  (define rank (make-vector (add1 max-num) 1))
  (for ([i (in-range (add1 max-num))])
    (vector-set! parent i i))

  (for ([x nums])
    (for ([y (in-range 2 (add1 (sqrt x)))])
      (when (= (modulo x y) 0)
        (union parent rank x y)
        (union parent rank x (/ x y)))))

  (define (get-root x)
    (find parent x))

  (define count (make-hash))
  (for ([x nums])
    (define root (get-root x))
    (hash-set! count root (+ (hash-ref count root 0) 1)))

  (apply max (hash-values count)))