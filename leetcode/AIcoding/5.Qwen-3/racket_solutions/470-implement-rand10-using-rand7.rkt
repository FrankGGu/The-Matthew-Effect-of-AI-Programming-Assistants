(define (rand7)
  (random 1 8))

(define (rand10)
  (let loop ()
    (let* ([a (rand7)]
           [b (rand7)]
           [num (+ (* 6 (- b 1)) (- a 1))])
      (if (<= num 36)
          (+ 1 (modulo num 10))
          (loop)))))