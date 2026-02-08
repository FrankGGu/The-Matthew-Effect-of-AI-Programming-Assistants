#lang racket

(define (best-criterion x y q)
  (if (> q 0) (+ x y) 0))

(define (get-qualities grid)
  (for*/list ([i (in-range (length grid))]
              [j (in-range (length (list-ref grid 0)))])
    (cons (list i j) (list-ref grid i j))))

(define (max-net-quality grid)
  (define rows (length grid))
  (define cols (length (list-ref grid 0)))
  (define qualities (get-qualities grid))
  (define max-quality 0)
  (define best-coords '())
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define current-quality 0)
      (for ([x (in-range (max 0 (- i 1)) (min rows (+ i 2)))]
            [y (in-range (max 0 (- j 1)) (min cols (+ j 2)))])
        (define q (list-ref (list-ref grid x) y))
        (when (> q 0)
          (set! current-quality (+ current-quality q))))
      (when (> current-quality max-quality)
        (set! max-quality current-quality)
        (set! best-coords (list i j)))
      (when (= current-quality max-quality)
        (set! best-coords (sort (list best-coords (list i j)) (lambda (a b) (or (< (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b)))))))))
  (car best-coords))