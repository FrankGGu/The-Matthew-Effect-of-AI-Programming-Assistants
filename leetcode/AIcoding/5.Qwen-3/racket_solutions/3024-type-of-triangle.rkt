(define (triangle-type a b c)
  (cond
    [(or (= (+ a b) c) (= (+ a c) b) (= (+ b c) a)) 'NotTriangle]
    [(and (= a b) (= b c)) 'Equilateral]
    [(or (= a b) (= b c) (= a c)) 'Isosceles]
    [else 'Scalene]))