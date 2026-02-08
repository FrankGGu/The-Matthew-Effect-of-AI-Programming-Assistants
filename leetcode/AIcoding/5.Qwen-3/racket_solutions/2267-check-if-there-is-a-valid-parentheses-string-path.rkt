#lang racket

(define (check-if-valid-string-path grid)
  (define (dfs i j left)
    (cond [(or (< i 0) (>= i (length grid)) (< j 0) (>= j (length (vector-ref grid 0))) (negative? left)) #f]
          [(and (= i (sub1 (length grid))) (= j (sub1 (length (vector-ref grid 0))))) (= left 0)]
          [else
           (let ([c (vector-ref (vector-ref grid i) j)])
             (if (char=? c #\())
                 (dfs (add1 i) j (add1 left))
                 (if (char=? c #\))
                     (dfs (add1 i) j (sub1 left))
                     (or (dfs (add1 i) j left)
                         (dfs i (add1 j) left))))]))
  (dfs 0 0 0))