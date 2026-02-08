(define (num-rabbits answers)
  (define (helper a b)
    (if (null? a)
        b
        (let* ((x (car a))
               (count (if (>= x b) (+ b 1) b))
               (remaining (- x b)))
          (helper (cdr a) count))))
  (helper answers 0))