(define (count-ways n)
  (define (dp i prev)
    (if (> i n)
        1
        (+ (if (and (not prev) (= i 1)) 1 0)
           (if (not prev) (dp (+ i 1) #t) 0)
           (dp (+ i 1) #f))))
  (dp 1 #f))