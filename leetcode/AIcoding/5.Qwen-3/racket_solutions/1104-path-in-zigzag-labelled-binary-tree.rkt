#lang racket

(define (path-in-zigzag-labelled-binary-tree target)
  (define (get-level x)
    (let loop ([x x] [level 0])
      (if (< x 1) level
          (loop (quotient x 2) (+ level 1)))))

  (define (get-label level index)
    (expt 2 level) (+ (expt 2 level) (- (expt 2 (sub1 level)) 1) (- index 1)))

  (define (get-index level label)
    (let ([min-label (expt 2 level)]
          [max-label (sub1 (expt 2 (add1 level)))])
      (- max-label label 1) + 1))

  (define (get-path target)
    (let ([path '()])
      (let loop ([target target] [level (get-level target)])
        (when (> level 0)
          (set! path (cons (get-label level (get-index level target)) path))
          (loop (quotient target 2) (sub1 level))))
      path))

  (get-path target))