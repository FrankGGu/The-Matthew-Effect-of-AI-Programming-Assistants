(define (peak-index-in-mountain-array arr)
  (let loop ((i 0))
    (if (> (list-ref arr i) (list-ref arr (+ i 1)))
        i
        (loop (+ i 1)))))