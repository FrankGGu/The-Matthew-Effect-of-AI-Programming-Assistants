(define (largest-combination nums)
  (define (count-bits n)
    (let loop ([n n] [count 0])
      (if (= n 0)
          count
          (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))

  (define bits (make-vector 20 0))
  (for-each
   (lambda (num)
     (let loop ([num num] [i 0])
       (when (< i 20)
         (when (bitwise-and num 1)
           (vector-set! bits i (+ (vector-ref bits i) 1)))
         (loop (arithmetic-shift num -1) (+ i 1)))))
   nums)

  (apply max (vector->list bits)))