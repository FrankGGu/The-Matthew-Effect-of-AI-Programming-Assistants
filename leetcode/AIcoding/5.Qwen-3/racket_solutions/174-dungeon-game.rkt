(define (calculateMinimumHP dungeon)
  (let* ([m (length dungeon)]
         [n (length (car dungeon))]
         [dp (make-array m n)])
    (array-set! dp (- (list-ref (last dungeon) (- n 1)) 1) (- m 1) (- n 1))
    (for ([i (in-range (- m 1) -1 -1)])
      (for ([j (in-range (- n 1) -1 -1)])
        (if (and (= i (- m 1)) (= j (- n 1)))
            #t
            (let* ([right (if (< j (- n 1)) (array-ref dp i (+ j 1)) #f)]
                   [down (if (< i (- m 1)) (array-ref dp (+ i 1) j) #f)]
                   [min-need (if (and right down) (min right down) (or right down))])
              (array-set! dp i j (max (- min-need 1) 0))))))
    (array-ref dp 0 0)))