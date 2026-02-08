#lang racket

(define (max-moves-to-kill-all-pawns grid)
  (define (dfs x y visited)
    (cond [(or (< x 0) (>= x (length grid)) (< y 0) (>= y (length (car grid))) (member (list x y) visited)) 0]
          [else
           (let ([current (list x y)])
             (if (equal? (list-ref grid x) (list-ref (list-ref grid x) y))
                 0
                 (let ([max-steps 0])
                   (for-each (lambda (dx dy)
                               (let ([steps (dfs (+ x dx) (+ y dy) (cons current visited))])
                                 (when (> steps max-steps)
                                   (set! max-steps steps))))
                             '((0 1) (1 0) (-1 0) (0 -1)))
                   (+ 1 max-steps)))]))
  (define (solve)
    (let ([max-steps 0])
      (for ([i (in-range (length grid))])
        (for ([j (in-range (length (car grid)))])
          (when (not (equal? (list-ref grid i) (list-ref (list-ref grid i) j)))
            (let ([steps (dfs i j '())])
              (when (> steps max-steps)
                (set! max-steps steps))))))
      max-steps))
  (solve))