#lang racket

(define (visible-points points ands)
  (define (angle x y)
    (if (and (= x 0) (= y 0))
        0.0
        (atan y x)))

  (define (sort-angle p)
    (angle (car p) (cadr p)))

  (define (count-visible angles)
    (define (helper i j count)
      (if (> i (length angles))
          count
          (let ([current (list-ref angles i)])
            (if (<= (- current (list-ref angles j)) (* 2 pi))
                (helper (+ i 1) j (+ count 1))
                (helper i (+ j 1) count)))))
    (let ([angles (append angles angles)])
      (helper 0 0 0)))

  (define (process points ands)
    (define (get-angles p)
      (map (lambda (a) (- (angle (car p) (cadr p)) (angle (car a) (cadr a)))) ands))
    (define angles (map get-angles points))
    (define sorted (map sort angles))
    (apply + (map count-visible sorted)))

  (process points ands))

(define (main)
  (define input (read))
  (define points (car input))
  (define ands (cadr input))
  (printf "~a\n" (visible-points points ands)))

(main)