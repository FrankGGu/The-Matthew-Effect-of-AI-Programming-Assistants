(define (distinct-nums nums)
  (let ([n (length nums)])
    (if (= n 1)
        nums
        (let ([sorted (sort nums <)])
          (let loop ([i 0] [res '()])
            (if (>= i n)
                res
                (loop (+ i 2) (cons (list-ref sorted i) res))))))))

(define (solve nums)
  (let ([n (length nums)])
    (if (= n 1)
        nums
        (let ([sorted (sort nums <)])
          (let ([res (make-vector n 0)])
            (let loop ([i 0] [j 0])
              (if (>= i n)
                  (vector->list res)
                  (begin
                    (vector-set! res j (list-ref sorted i))
                    (loop (+ i 1) (+ j 1))))))
            )))))

(define (main)
  (define input (read))
  (display (solve input)))

(main)