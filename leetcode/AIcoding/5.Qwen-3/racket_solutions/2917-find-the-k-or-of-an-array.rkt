(define (k-or nums k)
  (define (bit-count n)
    (let loop ([n n] [count 0])
      (if (= n 0)
          count
          (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))

  (define (get-bit i)
    (let loop ([nums nums] [count 0])
      (if (null? nums)
          count
          (loop (cdr nums) (+ count (if (= (bitwise-and (car nums) (arithmetic-shift 1 i)) (arithmetic-shift 1 i)) 1 0))))))

  (let loop ([i 0] [result 0])
    (if (> i 30)
        result
        (let ([cnt (get-bit i)])
          (if (>= cnt k)
              (loop (+ i 1) (bitwise-ior result (arithmetic-shift 1 i)))
              (loop (+ i 1) result))))))