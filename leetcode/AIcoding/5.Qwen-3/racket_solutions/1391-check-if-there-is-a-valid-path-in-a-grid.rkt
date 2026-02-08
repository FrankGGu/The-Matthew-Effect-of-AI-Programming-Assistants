(define (has-valid-path grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define directions '(() (0 1) (0 -1) (1 0) (-1 0)))
  (define (get-directions cell)
    (cond [(= cell 1) '(0 1 3)]
          [(= cell 2) '(1 2)]
          [(= cell 3) '(0 2)]
          [(= cell 4) '(0 1)]
          [(= cell 5) '(1 3)]
          [else '()]))
  (define visited (make-vector rows (make-vector cols #f)))
  (define (dfs r c path)
    (if (or (not (and (>= r 0) (< r rows) (>= c 0) (< c cols)))
            (vector-ref (vector-ref visited r) c)
            (null? path))
        #f
        (if (and (= r (sub1 rows)) (= c (sub1 cols)))
            #t
            (begin
              (vector-set! (vector-ref visited r) c #t)
              (let loop ([ds (get-directions (vector-ref (vector-ref grid r) c))])
                (if (null? ds)
                    #f
                    (let* ([d (car ds)]
                           [dr (list-ref directions d)]
                           [nr (+ r (car dr))]
                           [nc (+ c (cadr dr))])
                      (if (and (>= nr 0) (< nr rows) (>= nc 0) (< nc cols)
                               (not (vector-ref (vector-ref visited nr) nc))
                               (member (vector-ref (vector-ref grid nr) nc) (get-directions (vector-ref (vector-ref grid nr) nc))))
                          (or (dfs nr nc (get-directions (vector-ref (vector-ref grid nr) nc)))
                              (loop (cdr ds)))
                          (loop (cdr ds)))))))))
  (dfs 0 0 (get-directions (vector-ref (vector-ref grid 0) 0)))
  (vector-set! (vector-ref visited 0) 0 #f))