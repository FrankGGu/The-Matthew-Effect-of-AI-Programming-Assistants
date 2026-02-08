(define (min-subarray-len nums s)
  (let loop ([left 0] [right 0] [current-sum 0] [min-len #f])
    (cond
      [(= right (length nums)) min-len]
      [else
       (let ([new-sum (+ current-sum (list-ref nums right))])
         (loop left
               (+ right 1)
               new-sum
               (if (>= new-sum s)
                   (let loop2 ([l left] [sum current-sum])
                     (if (>= sum s)
                         (min min-len (- right l))
                         (loop2 (+ l 1) (- sum (list-ref nums l)))))
                   min-len)))])))