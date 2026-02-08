(define (min-domino-rotations-for-equal-row row)
  (define (count-rotations a b)
    (let loop ([i 0] [rotations 0])
      (if (= i (length row))
          rotations
          (let ([current-a (list-ref row i)]
                [current-b (list-ref row i)])
            (if (and (= current-a a) (= current-b b))
                (loop (+ i 1) rotations)
                (if (and (= current-a b) (= current-b a))
                    (loop (+ i 1) (+ rotations 1))
                    (error "Invalid input"))))
            )))
  (let ([a (car row)]
        [b (cadr row)])
    (min
     (count-rotations a b)
     (count-rotations b a)
     (count-rotations a (list-ref row 0))
     (count-rotations b (list-ref row 0)))))