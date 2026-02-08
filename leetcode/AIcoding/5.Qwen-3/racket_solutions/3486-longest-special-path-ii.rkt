#lang racket

(define (longest-special-path grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define dp (make-vector rows (make-vector cols -1)))

  (define (dfs i j)
    (if (>= i rows) 0
        (if (>= j cols) 0
            (if (not (= (vector-ref (vector-ref dp i) j) -1))
                (vector-ref (vector-ref dp i) j)
                (begin
                  (vector-set! (vector-ref dp i) j 0)
                  (for-each
                   (lambda (di dj)
                     (when (and (<= (+ i di) (- rows 1)) (<= (+ j dj) (- cols 1)))
                       (let ((ni (+ i di)) (nj (+ j dj)))
                         (when (> (vector-ref (vector-ref grid ni) nj) (vector-ref (vector-ref grid i) j))
                           (vector-set! (vector-ref dp i) j
                                        (max (vector-ref (vector-ref dp i) j)
                                             (+ 1 (dfs ni nj))))))))
                   '((0 1) (1 0) (0 -1) (-1 0) (1 1) (-1 -1) (1 -1) (-1 1))))
                  (vector-ref (vector-ref dp i) j)))))

  (for*/fold ([max-length 0])
             ([i (in-range rows)]
              [j (in-range cols)])
    (max max-length (dfs i j))))