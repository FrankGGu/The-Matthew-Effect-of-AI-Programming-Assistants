#lang racket

(define (max-square-area fences)
  (define (sort-fences lst)
    (sort lst <))

  (define sorted-fences (sort-fences fences))

  (define (find-max-square lst)
    (let loop ((i 0) (j (sub1 (length lst))) (max-side 0))
      (if (> i j)
          max-side
          (let* ((left (list-ref lst i))
                 (right (list-ref lst j))
                 (side (- right left)))
            (loop (if (< side max-side) i (add1 i))
                  (if (< side max-side) j (sub1 j))
                  (max max-side side))))))

  (find-max-square sorted-fences))