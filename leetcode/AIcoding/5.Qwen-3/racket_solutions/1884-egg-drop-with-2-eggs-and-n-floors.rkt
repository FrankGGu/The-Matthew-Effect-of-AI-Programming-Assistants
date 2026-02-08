(define (egg-drop n)
  (define (helper k)
    (if (>= (floor (+ (/ (- (sqrt (* 8 k) 8) 2) 1)) 1) n)
        k
        (helper (+ k 1))))
  (helper 1))