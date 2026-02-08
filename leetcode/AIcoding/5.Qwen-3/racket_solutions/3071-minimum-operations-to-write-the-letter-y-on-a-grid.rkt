(define (minimum-operations-to-write-the-letter-y grid)
  (define (get-y-coordinates n)
    (let loop ((i 0) (res '()))
      (if (>= i n)
          res
          (let* ((row i)
                 (col (if (< row (/ n 2)) i (- n 1 i))))
            (loop (+ i 1) (cons (list row col) res))))))

  (define n (length grid))
  (define y-coords (get-y-coordinates n))
  (define target #\y)
  (define (char-at r c) (string-ref (list-ref grid r) c))

  (define (count-ops r c)
    (if (char=? (char-at r c) target)
        0
        1))

  (apply + (map (lambda (pos) (count-ops (car pos) (cadr pos))) y-coords)))