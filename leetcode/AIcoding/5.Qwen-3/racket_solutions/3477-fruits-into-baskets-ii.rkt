#lang racket

(define (total-fruit tree)
  (define (helper i j max-count count)
    (if (>= i (length tree))
        max-count
        (let ((current (list-ref tree i)))
          (if (member current (map (lambda (x) (list-ref tree x)) (range j i)))
              (helper (+ i 1) j (max max-count (- i j + 1)) (+ count 1))
              (helper (+ i 1) (+ j 1) max-count 1)))))
  (helper 0 0 0 0))