(define (min-processing-time processor-time)
  (let ([sorted-proc (sort processor-time <)])
    (let loop ([i 0] [j (- (length sorted-proc) 1)] [max-time 0])
      (if (> i j)
          max-time
          (loop (+ i 1) (- j 1) (max max-time (+ (list-ref sorted-proc i) (list-ref sorted-proc j))))))))