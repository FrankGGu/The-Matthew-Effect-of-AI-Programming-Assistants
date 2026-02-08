#lang racket

(define (closest-cell grid)
  (let loop ([i 0] [j 0] [min-dist (length grid)])
    (cond [(>= i (length grid)) #f]
          [(>= j (length (list-ref grid i))) (loop (+ i 1) 0 min-dist)]
          [(and (= (list-ref (list-ref grid i) j) 0)
                (<= (abs (- i (sub1 (length grid)))) (abs (- j (sub1 (length (list-ref grid i)))))))
           (if (<= (abs (- i (sub1 (length grid)))) (abs (- j (sub1 (length (list-ref grid i))))))
               (loop (+ i 1) 0 (min min-dist (+ (abs (- i (sub1 (length grid)))) (abs (- j (sub1 (length (list-ref grid i))))))))
               (loop i (+ j 1) min-dist))]
          [else (loop i (+ j 1) min-dist)])))

(define (safe-walk? grid)
  (let ([start (closest-cell grid)])
    (if (not start) #f
        (let ([rows (length grid)] [cols (length (list-ref grid 0))])
          (let loop ([queue (list (cons start 0))] [visited (set)])
            (if (null? queue) #f
                (let* ([current (car queue)]
                       [pos (car current)]
                       [steps (cdr current)]
                       [i (car pos)]
                       [j (cdr pos)])
                  (if (and (= i (sub1 rows)) (= j (sub1 cols))) #t
                      (let ([neighbors (filter (lambda (p) (and (>= (car p) 0) (< (car p) rows) (>= (cdr p) 0) (< (cdr p) cols) (not (set-member? visited p)))) (list (cons (- i 1) j) (cons (+ i 1) j) (cons i (- j 1)) (cons i (+ j 1))))])
                        (loop (append (cdr queue) neighbors) (set-add visited pos))))))))))