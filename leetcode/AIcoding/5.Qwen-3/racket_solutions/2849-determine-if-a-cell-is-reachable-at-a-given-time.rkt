(define (is-reachable-at-time row col time)
  (define (abs x) (if (< x 0) (- x) x))
  (let ((d (abs (- row col))))
    (and (<= d time) (or (= d time) (>= time 2)))))