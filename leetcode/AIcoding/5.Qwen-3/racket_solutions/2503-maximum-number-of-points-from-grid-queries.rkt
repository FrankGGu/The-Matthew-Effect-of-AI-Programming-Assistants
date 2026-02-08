#lang racket

(define (maximum-points-from-grid-queries grid queries)
  (define (sort-queries queries)
    (sort queries (lambda (a b) (< (car a) (car b)))))

  (define (sort-grid grid)
    (map (lambda (row) (sort row <)) grid))

  (define (max-points grid queries)
    (let* ([sorted-grid (sort-grid grid)]
           [sorted-queries (sort-queries queries)]
           [n (length grid)]
           [m (length (car grid))]
           [result (make-vector (length queries) 0)])
      (let loop ([q 0] [i 0] [j 0] [points 0])
        (cond
          [(>= q (length sorted-queries)) result]
          [(and (>= i n) (>= j m)) (vector-set! result q points) (loop (+ q 1) 0 0 0)]
          [(and (>= i n) (< j m))
           (if (<= (list-ref (list-ref sorted-grid 0) j) (caar (list-ref sorted-queries q)))
               (loop q i (+ j 1) (+ points 1))
               (begin
                 (vector-set! result q points)
                 (loop (+ q 1) 0 0 0)))]
          [(and (< i n) (>= j m))
           (if (<= (list-ref (list-ref sorted-grid i) 0) (caar (list-ref sortedQueries q)))
               (loop q (+ i 1) 0 (+ points 1))
               (begin
                 (vector-set! result q points)
                 (loop (+ q 1) 0 0 0)))]
          [else
           (if (<= (list-ref (list-ref sorted-grid i) j) (caar (list-ref sorted-queries q)))
               (loop q (+ i 1) (+ j 1) (+ points 1))
               (begin
                 (vector-set! result q points)
                 (loop (+ q 1) 0 0 0)))])))
      result))

  (define (process-queries grid queries)
    (let ([sorted-queries (sort-queries queries)])
      (let ([sorted-grid (sort-grid grid)])
        (let ([n (length grid)]
              [m (length (car grid))])
          (let loop ([q 0] [i 0] [j 0] [points 0] [res '()])
            (if (>= q (length sorted-queries))
                (reverse res)
                (let ([current-query (caar (list-ref sorted-queries q))])
                  (let loop2 ([i i] [j j] [points points])
                    (cond
                      [(or (>= i n) (>= j m))
                       (loop (+ q 1) 0 0 0 (cons points res))]
                      [(<= (list-ref (list-ref sorted-grid i) j) current-query)
                       (loop2 (+ i 1) (+ j 1) (+ points 1))]
                      [else
                       (loop (+ q 1) 0 0 0 (cons points res))]))))))))

  (define (solve grid queries)
    (let ([sorted-queries (sort-queries queries)])
      (let ([sorted-grid (sort-grid grid)])
        (let ([n (length grid)]
              [m (length (car grid))])
          (let ([res (make-vector (length queries) 0)])
            (let loop ([q 0] [i 0] [j 0] [points 0])
              (cond
                [(>= q (length queries)) res]
                [(and (>= i n) (>= j m))
                 (vector-set! res q points)
                 (loop (+ q 1) 0 0 0)]
                [(and (>= i n) (< j m))
                 (if (<= (list-ref (list-ref sorted-grid 0) j) (caar (list-ref sorted-queries q)))
                     (loop q i (+ j 1) (+ points 1))
                     (begin
                       (vector-set! res q points)
                       (loop (+ q 1) 0 0 0)))]
                [(and (< i n) (>= j m))
                 (if (<= (list-ref (list-ref sorted-grid i) 0) (caar (list-ref sorted-queries q)))
                     (loop q (+ i 1) 0 (+ points 1))
                     (begin
                       (vector-set! res q points)
                       (loop (+ q 1) 0 0 0)))]
                [else
                 (if (<= (list-ref (list-ref sorted-grid i) j) (caar (list-ref sorted-queries q)))
                     (loop q (+ i 1) (+ j 1) (+ points 1))
                     (begin
                       (vector-set! res q points)
                       (loop (+ q 1) 0 0 0)))]))
            res))))

  (let ([sorted-queries (sort-queries queries)])
    (let ([sorted-grid (sort-grid grid)])
      (let ([n (length grid)]
            [m (length (car grid))])
        (let ([res (make-vector (length queries) 0)])
          (let loop ([q 0] [i 0] [j 0] [points 0])
            (cond
              [(>= q (length queries)) res]
              [(and (>= i n) (>= j m))
               (vector-set! res q points)
               (loop (+ q 1) 0 0 0)]
              [(and (>= i n) (< j m))
               (if (<= (list-ref (list-ref sorted-grid 0) j) (caar (list-ref sorted-queries q)))
                   (loop q i (+ j 1) (+ points 1))
                   (begin
                     (vector-set! res q points)
                     (loop (+ q 1) 0 0 0)))]
              [(and (< i n) (>= j m))
               (if (<= (list-ref (list-ref sorted-grid i) 0) (caar (list-ref sorted-queries q)))
                   (loop q (+ i 1) 0 (+ points 1))
                   (begin
                     (vector-set! res q points)
                     (loop (+ q 1) 0 0 0)))]
              [else
               (if (<= (list-ref (list-ref sorted-grid i) j) (caar (list-ref sorted-queries q)))
                   (loop q (+ i 1) (+ j 1) (+ points 1))
                   (begin
                     (vector-set! res q points)
                     (loop (+ q 1) 0 0 0)))]))
          res))))))

(define (main)
  (define grid (read))
  (define queries (read))
  (define result (maximum-points-from-grid-queries grid queries))
  (displayln result))

(main)