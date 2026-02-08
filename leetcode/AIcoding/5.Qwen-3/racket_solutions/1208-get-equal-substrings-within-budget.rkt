(define (equal-substrings s t max-cost)
  (define n (string-length s))
  (define (cost i)
    (- (char->integer (string-ref s i)) (char->integer (string-ref t i))))
  (define (abs x) (if (>= x 0) x (- x)))
  (let loop ([left 0] [right 0] [current-cost 0] [max-len 0])
    (cond [(> right n) max-len]
          [else
           (let ([new-cost (+ current-cost (abs (cost right)))])
             (if (<= new-cost max-cost)
                 (loop left (+ right 1) new-cost (max max-len (- right left + 1)))
                 (loop (+ left 1) right (- current-cost (abs (cost left))) max-len)))])))