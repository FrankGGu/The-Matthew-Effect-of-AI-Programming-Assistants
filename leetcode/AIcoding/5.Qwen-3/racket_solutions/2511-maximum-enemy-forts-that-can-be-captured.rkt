(define (capture-forts forts)
  (define (max-captured)
    (let loop ([i 0] [max 0] [count 0] [prev -1])
      (if (= i (length forts))
          max
          (let ([f (list-ref forts i)])
            (cond
              [(= f 1)
               (loop (+ i 1) max 0 i)]
              [(= f -1)
               (if (= prev -1)
                   (loop (+ i 1) max 0 i)
                   (loop (+ i 1) (max max count) 0 i))]
              [else
               (loop (+ i 1) max (+ count 1) prev)]))))
    )
  (max-captured))