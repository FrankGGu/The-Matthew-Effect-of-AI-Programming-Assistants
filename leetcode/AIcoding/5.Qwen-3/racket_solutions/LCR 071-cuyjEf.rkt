#lang racket

(define (rand-int n)
  (exact-floor (* (random) n)))

(define (new-ProbDist w)
  (let ((prefix (make-vector (length w) 0)))
    (vector-set! prefix 0 (vector-ref w 0))
    (for ([i (in-range 1 (length w))])
      (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (vector-ref w i))))
    (lambda ()
      (let ((r (rand-int (vector-ref prefix (- (length w) 1)))))
        (let loop ([i 0])
          (if (< r (vector-ref prefix i))
              i
              (loop (+ i 1))))))))

(define (prob-dist-select dist)
  (dist))