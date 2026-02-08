#lang racket

(define (outer-tree points)
  (define (cross o a b)
    (- (* (- (car a) (car o)) (- (cdr b) (cdr o))) (* (- (cdr a) (cdr o)) (- (car b) (car o)))))

  (define (compare p1 p2)
    (let ((c (cross (car points) p1 p2)))
      (if (= c 0)
          (- (distance (car points) p2) (distance (car points) p1))
          (if (> c 0) -1 1))))

  (define (distance p1 p2)
    (+ (expt (- (car p1) (car p2)) 2) (expt (- (cdr p1) (cdr p2)) 2)))

  (define (convex-hull)
    (let ((sorted (sort points compare)))
      (let loop ((l (list (car sorted))) (r (list (car sorted))) (i 1))
        (if (= i (length sorted))
            (append (reverse l) (reverse r))
            (let ((p (list-ref sorted i)))
              (let ((ll (append l (list p)))
                    (rr (append r (list p))))
                (let ((cl (cross (last l) (second l) p))
                      (cr (cross (last r) (second r) p)))
                  (if (and (>= cl 0) (>= cr 0))
                      (loop ll rr (+ i 1))
                      (if (>= cl 0)
                          (loop ll (reverse (cdr rr)) (+ i 1))
                          (loop (reverse (cdr ll)) rr (+ i 1))))))))))

  (if (< (length points) 3)
      points
      (convex-hull)))

(define (erect-the-fence points)
  (outer-tree points))