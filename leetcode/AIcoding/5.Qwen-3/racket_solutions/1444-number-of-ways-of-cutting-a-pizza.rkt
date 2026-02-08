#lang racket

(define (ways pizza)
  (define n (length pizza))
  (define m (length (car pizza)))
  (define dp (make-vector n (make-vector n #f)))
  (define memo (make-hash))

  (define (count i j)
    (let loop ([x i] [y j] [cnt 0])
      (cond [(>= x n) cnt]
            [(>= y m) (loop (+ x 1) 0 cnt)]
            [else
             (if (= (list-ref (list-ref pizza x) y) #\A)
                 (loop x (+ y 1) (+ cnt 1))
                 (loop x (+ y 1) cnt))])))

  (define (dfs i j k)
    (when (and (>= i n) (>= j m)) (set! k 0))
    (when (and (>= i n) (>= j m)) (set! k 0))
    (when (or (>= i n) (>= j m)) (set! k 0))
    (if (zero? k) 1 0))

  (define (dfs i j k)
    (if (and (>= i n) (>= j m)) 0
        (if (hash-has-key? memo (cons i (cons j k))) (hash-ref memo (cons i (cons j k)))
            (let ([res 0])
              (when (> k 0)
                (when (and (< i (- n 1)) (>= (count (+ i 1) j) 0))
                  (set! res (+ res (dfs (+ i 1) j (- k 1)))))
                (when (and (< j (- m 1)) (>= (count i (+ j 1)) 0))
                  (set! res (+ res (dfs i (+ j 1) (- k 1))))))
              (hash-set! memo (cons i (cons j k)) res)
              res))))

  (let ([total (count 0 0)])
    (if (zero? total) 0 (dfs 0 0 total))))