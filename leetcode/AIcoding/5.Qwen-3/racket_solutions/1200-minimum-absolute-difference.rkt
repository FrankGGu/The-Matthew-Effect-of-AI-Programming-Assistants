#lang racket

(define (minimum-absolute-difference arr)
  (define sorted-arr (sort arr <))
  (define min-diff (apply min (map - (cdr sorted-arr) (reverse (take sorted-arr (- (length sorted-arr) 1))))))
  (filter (lambda (x) (= (abs (- (second x) (first x))) min-diff)) (map list (take sorted-arr (- (length sorted-arr) 1)) (drop sorted-arr 1))))

(define (main)
  (define input (read))
  (display (minimum-absolute-difference input)))

(main)