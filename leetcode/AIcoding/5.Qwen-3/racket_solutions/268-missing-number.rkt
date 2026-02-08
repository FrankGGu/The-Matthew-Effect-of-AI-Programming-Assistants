(define (missing-number nums)
  (let ((n (length nums)))
    (- (* n (+ n 1)) (* 2 (apply + nums)))))