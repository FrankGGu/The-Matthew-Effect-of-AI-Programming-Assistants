(define (unique-paths m n)
  (define (factorial x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))))
  (define (comb a b)
    (/ (factorial a) (* (factorial b) (factorial (- a b)))))
  (comb (+ m n -2) (- m 1)))