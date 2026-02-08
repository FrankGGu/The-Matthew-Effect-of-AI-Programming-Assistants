(define (stone-game-iii s)
  (define n (string-length s))
  (define dp (make-vector n #f))
  (define (get i)
    (if (>= i n) 0 (vector-ref dp i)))
  (define (solve i)
    (if (>= i n) 0
        (if (vector-ref dp i)
            (vector-ref dp i)
            (let* ([a (if (< (+ i 1) n) (string-ref s (+ i 1)) #\0)]
                   [b (if (< (+ i 2) n) (string-ref s (+ i 2)) #\0)]
                   [c (if (< (+ i 3) n) (string-ref s (+ i 3)) #\0)]
                   [val1 (- (char->integer a) 48)]
                   [val2 (- (char->integer b) 48)]
                   [val3 (- (char->integer c) 48)]
                   [res (min (- (if (< (+ i 1) n) (solve (+ i 1)) 0) val1)
                             (- (if (< (+ i 2) n) (solve (+ i 2)) 0) val2)
                             (- (if (< (+ i 3) n) (solve (+ i 3)) 0) val3))])
              (vector-set! dp i res)
              res))))
  (let ([res (solve 0)])
    (cond [(> res 0) "Alice"]
          [(< res 0) "Bob"]
          [else "Tie"])))