(define (max-points points)
  (define (max-points-helper points prev-idx)
    (if (null? points)
        0
        (let ((current (car points)))
          (let ((max-val (apply max (map (lambda (i) (- (distance current (list-ref points i)) (max-points-helper (append (take points i) (drop points (+ i 1))) i))) (range 0 (length points)))))
            (if (= prev-idx -1)
                max-val
                (+ max-val (distance current (list-ref points prev-idx))))))))
  (max-points-helper points -1))

(define (distance p1 p2)
  (sqrt (+ (expt (- (car p1) (car p2)) 2) (expt (- (cadr p1) (cadr p2)) 2))))

(define (solve)
  (let ((n (string->number (read-line))))
    (let loop ((i 0) (points '()))
      (if (= i n)
          (display (max-points points))
          (loop (+ i 1) (cons (map string->number (string-split (read-line))) points))))))