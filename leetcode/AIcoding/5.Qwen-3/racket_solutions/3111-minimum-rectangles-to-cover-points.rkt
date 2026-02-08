(define (min-rectangles-to-cover-points points)
  (define (count x y)
    (if (or (zero? x) (zero? y)) 0 1))
  (define (key p)
    (let ((x (car p)) (y (cadr p)))
      (cons (if (positive? x) 1 0) (if (positive? y) 1 0))))
  (define (group p)
    (let ((x (car p)) (y (cadr p)))
      (if (and (positive? x) (positive? y)) 1
          (if (and (negative? x) (positive? y)) 2
              (if (and (negative? x) (negative? y)) 3
                  4)))))
  (define (count-group g)
    (case g
      ((1) 1)
      ((2) 1)
      ((3) 1)
      ((4) 1)))
  (define groups (map group points))
  (apply + (map count-group groups)))