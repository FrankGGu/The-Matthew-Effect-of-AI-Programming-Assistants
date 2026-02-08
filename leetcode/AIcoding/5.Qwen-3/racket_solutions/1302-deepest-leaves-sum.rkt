#lang racket

(define (deepest-leaves-sum root)
  (define (get-depth node)
    (if (not node)
        0
        (add1 (max (get-depth (car node)) (get-depth (cadr node))))))

  (define (sum-deepest node depth target-depth)
    (if (not node)
        0
        (if (= depth target-depth)
            (+ (caar node) (sum-deepest (car node) (add1 depth) target-depth) (sum-deepest (cadr node) (add1 depth) target-depth))
            (+ (sum-deepest (car node) (add1 depth) target-depth) (sum-deepest (cadr node) (add1 depth) target-depth)))))

  (define depth (get-depth root))
  (sum-deepest root 1 depth))