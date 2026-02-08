(define (nearest-point x y points)
  (define (distance i j x0 y0)
    (abs (- i x0)) 
    (abs (- j y0))
    (+ (abs (- i x0)) (abs (- j y0))))
  (define (helper points min-dist index result)
    (cond [(null? points) result]
          [else
           (let* ([p (car points)]
                  [i (car p)]
                  [j (cadr p)]
                  [d (distance i j x y)])
             (if (or (and (= i x) (= j y))
                     (and (= i x) (< d min-dist))
                     (and (= j y) (< d min-dist)))
                 (helper (cdr points) d index (cons p '()))
                 (helper (cdr points) min-dist index result)))]))
  (let ([res (helper points +inf.0 0 '())])
    (if (null? res) -1 (caar res))))