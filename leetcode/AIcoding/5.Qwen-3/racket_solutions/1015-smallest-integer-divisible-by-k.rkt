(define (refactor k)
  (let loop ([n 0] [remainder 0])
    (if (= remainder 0)
        n
        (loop (+ n 1) (modulo (+ (* remainder 10) 1) k)))))

(define (smallest-divisible k)
  (if (= k 1)
      1
      (refactor k)))