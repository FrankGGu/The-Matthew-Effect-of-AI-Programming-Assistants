(define-struct quad (value is-leaf topLeft topRight bottomLeft bottomRight))

(define (construct grid)
  (define (build n x y)
    (if (= n 1)
        (make-quad (equal? (list-ref (list-ref grid y) x) #\1) #t #f #f #f #f)
        (let* ([half (/ n 2)]
               [topLeft (build half x y)]
               [topRight (build half (+ x half) y)]
               [bottomLeft (build half x (+ y half))]
               [bottomRight (build half (+ x half) (+ y half))])
          (if (and (eqv? (quad-value topLeft) (quad-value topRight))
                   (eqv? (quad-value topLeft) (quad-value bottomLeft))
                   (eqv? (quad-value topLeft) (quad-value bottomRight))
                   (quad-is-leaf topLeft)
                   (quad-is-leaf topRight)
                   (quad-is-leaf bottomLeft)
                   (quad-is-leaf bottomRight))
              (make-quad (quad-value topLeft) #t #f #f #f #f)
              (make-quad #f #f topLeft topRight bottomLeft bottomRight)))))
  (build (length grid) 0 0))