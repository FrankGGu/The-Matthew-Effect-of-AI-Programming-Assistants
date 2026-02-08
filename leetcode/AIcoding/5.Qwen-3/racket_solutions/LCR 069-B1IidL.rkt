(define (peak-index-in-mountain-array arr)
  (let loop ((left 0) (right (- (length arr) 1)))
    (if (= left right)
        left
        (let* ((mid (quotient (+ left right) 2))
               (val (list-ref arr mid)))
          (if (< val (list-ref arr (+ mid 1)))
              (loop (+ mid 1) right)
              (loop left mid))))))