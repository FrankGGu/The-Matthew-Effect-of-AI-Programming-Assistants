(define/contract (max-area-of-island grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (dfs i j visited)
    (if (or (< i 0) (>= i (length grid)) (< j 0) (>= j (length (car grid))) (not (= (list-ref (list-ref grid i) j) 1)) (hash-has-key? visited (cons i j)))
        0
        (begin
          (hash-set! visited (cons i j) #t)
          (+ 1
             (dfs (+ i 1) j visited)
             (dfs (- i 1) j visited)
             (dfs i (+ j 1) visited)
             (dfs i (- j 1) visited)))))
  (define visited (make-hash))
  (define max-area 0)
  (for ([i (in-range (length grid))])
    (for ([j (in-range (length (car grid)))]
          #:when (= (list-ref (list-ref grid i) j) 1))
      (define area (dfs i j visited))
      (set! max-area (max max-area area))))
  max-area)