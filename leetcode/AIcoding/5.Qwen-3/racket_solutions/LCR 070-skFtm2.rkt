(define (single-non-repeating nums)
  (let loop ([i 0])
    (if (>= i (length nums))
        #f
        (let ([val (list-ref nums i)])
          (if (and (< i (- (length nums) 1))
                   (= val (list-ref nums (+ i 1))))
              (loop (+ i 2))
              val)))))