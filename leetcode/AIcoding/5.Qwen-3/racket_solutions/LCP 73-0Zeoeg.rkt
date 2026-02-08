(define (solve)
  (let ((n (read)))
    (let loop ((i 0) (sum 0))
      (if (>= i n)
          sum
          (loop (+ i 1) (+ sum (read)))))))