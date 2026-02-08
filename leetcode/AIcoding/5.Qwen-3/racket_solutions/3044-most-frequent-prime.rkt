#lang racket

(define (most-frequent-prime grid)
  (define (is-prime? n)
    (cond [(<= n 1) #f]
          [(= n 2) #t]
          [(even? n) #f]
          [else
           (let loop ([i 3])
             (if (> i (sqrt n)) #t
                 (if (= (modulo n i) 0) #f
                     (loop (+ i 2)))))]))

  (define (get-primes x y)
    (define (helper x y dir-x dir-y)
      (let loop ([x x] [y y] [res '()])
        (if (or (< x 0) (>= x (length grid)) (< y 0) (>= y (length (car grid))))
            (reverse res)
            (loop (+ x dir-x) (+ y dir-y) (cons (list-ref (list-ref grid y) x) res)))))

    (define (get-directions x y)
      (append
       (if (and (>= x 0) (< x (length grid)) (>= y 0) (< y (length (car grid))))
           (list (helper x y 0 1) (helper x y 1 0) (helper x y 1 1) (helper x y -1 1))
           '())))

    (apply append (map (lambda (d) (filter is-prime? d)) (get-directions x y))))

  (define primes (apply append (for*/list ([i (in-range (length grid))] [j (in-range (length (car grid)))]) (get-primes i j))))

  (define freq (make-hash))
  (for-each (lambda (p) (hash-update! freq p add1 0)) primes)
  (if (null? primes)
      -1
      (let ([max-count 0] [max-prime -1])
        (for ([k (in-hash-keys freq)])
          (define count (hash-ref freq k))
          (when (> count max-count)
            (set! max-count count)
            (set! max-prime k))
          (when (= count max-count)
            (when (< k max-prime)
              (set! max-prime k))))
        max-prime)))