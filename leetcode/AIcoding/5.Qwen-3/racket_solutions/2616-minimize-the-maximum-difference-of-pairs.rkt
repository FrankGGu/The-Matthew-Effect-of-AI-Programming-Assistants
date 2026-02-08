#lang racket

(define (minimize-max-difference nums p)
  (define (possible? target)
    (let loop ([i 0] [count 0])
      (cond [(>= i (- (length nums) 1)) (>= count p)]
            [(<= (abs (- (list-ref nums i) (list-ref nums (+ i 1)))) target)
             (loop (+ i 2) (+ count 1))]
            [else (loop (+ i 1) count)])))
  (let ([nums (sort nums <)])
    (let loop ([low 0] [high (- (last nums) (first nums))])
      (if (<= low high)
          (let ([mid (quotient (+ low high) 2)])
            (if (possible? mid)
                (loop low (- mid 1))
                (loop (+ mid 1) high)))
          low))))