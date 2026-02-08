#lang racket

(define (find-minimum-diameter-after-merging-two-trees root1 root2)
  (define (get-height node)
    (if (not node)
        0
        (max (get-height (car node)) (get-height (cadr node))) + 1))

  (define (get-deepest-left-right node)
    (if (not node)
        (values 0 0)
        (let* ([left (get-deepest-left-right (car node))]
              [right (get-deepest-left-right (cadr node))]
              [left-depth (car left)]
              [right-depth (cdr left)]
              [new-left (max left-depth (add1 (car right)))]
              [new-right (max right-depth (add1 (cdr right)))])
          (values new-left new-right))))

  (define (get-max-path node)
    (if (not node)
        0
        (let* ([left (get-deepest-left-right (car node))]
              [right (get-deepest-left-right (cadr node))]
              [left-depth (car left)]
              [right-depth (cdr left)]
              [current-path (+ left-depth right-depth 2)])
          (max current-path (get-max-path (car node)) (get-max-path (cadr node))))))

  (let* ([height1 (get-height root1)]
         [height2 (get-height root2)]
         [diameter1 (get-max-path root1)]
         [diameter2 (get-max-path root2)]
         [combined-diameter (+ height1 height2 1)])
    (min (min diameter1 diameter2) combined-diameter)))