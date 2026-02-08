#lang racket

(define (sort-matrix-diagonally matrix)
  (define (get-diagonal start-row start-col)
    (let loop ([row start-row] [col start-col] [diag '()])
      (if (or (>= row (length matrix)) (>= col (length (car matrix))))
          diag
          (loop (+ row 1) (+ col 1) (cons (list-ref (list-ref matrix row) col) diag)))))

  (define (set-diagonal start-row start-col values)
    (let loop ([row start-row] [col start-col] [values values])
      (when (and (< row (length matrix)) (< col (length (car matrix))))
        (set! (list-ref (list-ref matrix row) col) (car values))
        (loop (+ row 1) (+ col 1) (cdr values)))))

  (define rows (length matrix))
  (define cols (if (> rows 0) (length (car matrix)) 0))

  (for ([i (in-range rows)])
    (define diag (get-diagonal i 0))
    (set-diagonal i 0 (sort diag <)))

  (for ([j (in-range 1 cols)])
    (define diag (get-diagonal 0 j))
    (set-diagonal 0 j (sort diag <)))

  matrix)