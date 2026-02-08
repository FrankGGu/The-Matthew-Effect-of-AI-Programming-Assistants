(define (max-area-of-island grid)
  (define (dfs i j)
    (if (or (< i 0) (>= i (length grid)) (< j 0) (>= j (length (car grid))) (not (equal? (list-ref grid i) (list-ref (list-ref grid i) j))))
        0
        (begin
          (set! grid (map (lambda (row) (if (= row (list-ref grid i)) (map (lambda (x) (if (= x (list-ref (list-ref grid i) j)) 0 x)) row) row)) grid))
          (+ 1 (dfs (+ i 1) j) (dfs (- i 1) j) (dfs i (+ j 1)) (dfs i (- j 1))))))
  (define (max-area i j res)
    (if (= i (length grid))
        res
        (if (= j (length (car grid)))
            (max-area (+ i 1) 0 res)
            (max-area i (+ j 1) (max res (if (equal? (list-ref grid i) (list-ref (list-ref grid i) j)) (dfs i j) 0))))))
  (max-area 0 0 0))