(define (max-distance-to-closest-person people)
  (let loop ([i 0] [prev -1] [max-dist 0])
    (if (= i (length people))
        max-dist
        (let ([current (list-ref people i)])
          (if (= current 1)
              (loop (+ i 1) i (max max-dist (- i prev)))
              (loop (+ i 1) prev max-dist))))))