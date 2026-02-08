#lang racket

(define (num-possible-points points)
  (define (distance p1 p2)
    (sqrt (+ (sqr (- (car p1) (car p2))) (sqr (- (cadr p1) (cadr p2))))))
  (define (midpoint p1 p2)
    (list (/ (+ (car p1) (car p2)) 2.0) (/ (+ (cadr p1) (cadr p2)) 2.0)))
  (define (perpendicular-bisector p1 p2)
    (let* ([dx (- (car p2) (car p1))]
           [dy (- (cadr p2) (cadr p1))])
      (if (= dx 0)
          (cons 'x (list (car p1) (car p2)))
          (cons 'y (list (cadr p1) (cadr p2))))))
  (define (line-intersection l1 l2)
    (cond [(and (eq? (car l1) 'x) (eq? (car l2) 'x))
           #f]
          [(and (eq? (car l1) 'y) (eq? (car l2) 'y))
           #f]
          [(eq? (car l1) 'x)
           (let ([x (cadr l1)])
             (if (eq? (car l2) 'y)
                 (list x (cadr l2))
                 (let ([m (car l2)]
                       [b (cadr l2)])
                   (list x (+ (* m x) b)))))]
          [(eq? (car l2) 'x)
           (let ([x (cadr l2)])
             (if (eq? (car l1) 'y)
                 (list x (cadr l1))
                 (let ([m (car l1)]
                       [b (cadr l1)])
                   (list x (+ (* m x) b)))))]
          [else
           (let* ([m1 (car l1)]
                  [b1 (cadr l1)]
                  [m2 (car l2)]
                  [b2 (cadr l2)]
                  [x (/ (- b2 b1) (- m1 m2))])
             (list x (+ (* m1 x) b1)))]))
  (define (circle-center p1 p2 p3)
    (let* ([mb1 (perpendicular-bisector p1 p2)]
           [mb2 (perpendicular-bisector p1 p3)]
           [center (line-intersection mb1 mb2)])
      (if center
          center
          #f)))
  (define (is-circle-valid center p1 p2 p3)
    (let ([d1 (distance center p1)]
          [d2 (distance center p2)]
          [d3 (distance center p3)])
      (and (<= (abs (- d1 d2)) 1e-8)
           (<= (abs (- d1 d3)) 1e-8))))
  (define (count-points center points)
    (for/sum ([p points])
      (if (<= (distance center p) 1e-8) 1 0)))
  (define (solve)
    (cond [(= (length points) 1) 1]
          [(= (length points) 2) (length points)]
          [else
           (define n (length points))
           (define result 0)
           (for ([i (in-range n)])
             (for ([j (in-range (add1 i) n)])
               (define p1 (list-ref points i))
               (define p2 (list-ref points j))
               (define mid (midpoint p1 p2))
               (define len (distance p1 p2))
               (when (> len 0)
                 (define dx (- (car p2) (car p1)))
                 (define dy (- (cadr p2) (cadr p1)))
                 (define perp (list (- dy) dx))
                 (define r (/ len 2.0))
                 (define (get-circle-point k)
                   (let ([x (+ (car mid) (* k (car perp)))]
                         [y (+ (cadr mid) (* k (cadr perp)))])
                     (list x y)))
                 (define (check-point p)
                   (when (and (>= (distance p1 p) 1e-8)
                              (>= (distance p2 p) 1e-8))
                     (define center (circle-center p1 p2 p))
                     (when (and center (is-circle-valid center p1 p2 p))
                       (set! result (max result (count-points center points))))))
                 (check-point (get-circle-point 1.0))
                 (check-point (get-circle-point -1.0)))))
           (for ([i (in-range n)])
             (for ([j (in-range (add1 i) n)])
               (for ([k (in-range (add1 j) n)])
                 (define p1 (list-ref points i))
                 (define p2 (list-ref points j))
                 (define p3 (list-ref points k))
                 (define center (circle-center p1 p2 p3))
                 (when center
                   (set! result (max result (count-points center points)))))))
           result]))
  (solve))

(define (maximum-number-of-darts-inside-of-a-circular-dartboard points)
  (num-possible-points points))