(define (range-bitwise-and)
  (let ((left (read)))
    (let ((right (read)))
      (let loop ((n right))
        (if (< n left)
            n
            (loop (bitwise-and n (sub1 n))))))))