#lang racket

(define (count-almost-equal-pairs nums)
  (define (count x y)
    (define (helper a b)
      (cond [(= a b) 0]
            [(= (remainder a 10) (remainder b 10)) (+ 1 (helper (quotient a 10) (quotient b 10)))]
            [else 100]))
    (if (= (abs (- x y)) 0)
        0
        (helper x y)))
  (define (check x y)
    (<= (count x y) 1))
  (define len (length nums))
  (define (loop i j)
    (cond [(>= i len) 0]
          [(>= j len) (loop (+ i 1) 0)]
          [else (if (check (list-ref nums i) (list-ref nums j))
                    (+ 1 (loop i (+ j 1)))
                    (loop i (+ j 1)))]))
  (loop 0 0))