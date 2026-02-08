#lang racket

(define (is-power-of-three n)
  (if (<= n 0)
      #f
      (let loop ((n n))
        (if (= n 1)
            #t
            (if (= (remainder n 3) 0)
                (loop (/ n 3))
                #f)))))