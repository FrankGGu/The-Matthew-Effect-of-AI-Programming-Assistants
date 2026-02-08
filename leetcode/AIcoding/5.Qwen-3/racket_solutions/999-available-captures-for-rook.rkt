(define (num-rook-captures board)
  (define (find-rook)
    (for*/first ([i (in-range 8)]
                 [j (in-range 8)]
                 #:when (char=? #\R (string-ref (list-ref board i) j)))
      (values i j)))

  (define (count-direction dx dy)
    (let loop ([x (+ dx (car (find-rook)))]
               [y (+ dy (cdr (find-rook)))])
      (cond [(or (< x 0) (>= x 8) (< y 0) (>= y 8)) 0]
            [(char=? #\p (string-ref (list-ref board x) y)) 1]
            [(char=? #\0 (string-ref (list-ref board x) y)) 0]
            [else (loop (+ dx x) (+ dy y))])))

  (define directions '([0 1] [1 0] [0 -1] [-1 0]))
  (apply + (map (lambda (d) (count-direction (car d) (cadr d))) directions)))