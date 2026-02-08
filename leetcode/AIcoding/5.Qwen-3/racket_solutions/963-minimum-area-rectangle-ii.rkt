(define (min-area-rectangle points)
  (define point-set (set->hash-set (map (lambda (p) (cons (car p) (cadr p))) points)))
  (define (get-points x y)
    (filter (lambda (p) (and (= (car p) x) (= (cadr p) y))) points))
  (define (has-point? x y)
    (set-member? point-set (cons x y)))
  (define min-area (expt 2 30))
  (for ([i (in-range (length points))])
    (for ([j (in-range (add1 i) (length points))])
      (let* ([x1 (caar (list-ref points i))]
             [y1 (cadar (list-ref points i))]
             [x2 (caar (list-ref points j))]
             [y2 (cadar (list-ref points j))])
        (when (not (= x1 x2))
          (when (not (= y1 y2))
            (let* ([x3 (+ x1 (- x2 x1) (- x1 x2))]
                   [y3 (+ y1 (- y2 y1) (- y1 y2))]
                   [x4 (+ x2 (- x1 x2) (- x2 x1))]
                   [y4 (+ y2 (- y1 y2) (- y2 y1))])
              (when (and (has-point? x3 y3) (has-point? x4 y4))
                (let* ([area (abs (* (- x2 x1) (- y2 y1)))]
                       [new-area (if (and (has-point? x3 y3) (has-point? x4 y4)) area min-area)])
                  (set! min-area (min min-area new-area)))))))))
  (if (= min-area (expt 2 30)) -1 min-area))