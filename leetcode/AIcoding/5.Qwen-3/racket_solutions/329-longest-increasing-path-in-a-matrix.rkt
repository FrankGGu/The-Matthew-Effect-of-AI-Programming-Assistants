#lang racket

(define (longest-increasing-path matrix)
  (define rows (length matrix))
  (define cols (if (> rows 0) (length (car matrix)) 0))
  (define dp (make-vector (* rows cols) -1))

  (define (dfs i j)
    (cond [(vector-ref dp (+ (* i cols) j)) => values]
          [else
           (define max-len 1)
           (for-each
            (lambda (dir)
              (define ni (+ i (car dir)))
              (define nj (+ j (cadr dir)))
              (when (and (>= ni 0) (< ni rows) (>= nj 0) (< nj cols))
                (when (> (list-ref matrix ni) (list-ref matrix i j))
                  (set! max-len (max max-len (+ (dfs ni nj) 1))))))
            '((0 -1) (0 1) (-1 0) (1 0)))
           (vector-set! dp (+ (* i cols) j) max-len)
           max-len]))

  (define max-path 0)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (set! max-path (max max-path (dfs i j))))
    )
  max-path)