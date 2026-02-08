#lang racket

(define (is-even-odd-tree root)
  (define (helper nodes level)
    (cond [(null? nodes) #t]
          [else
           (let ([current-level (map car nodes)]
                 [next-nodes (append* (map cdr nodes))])
             (and (if (even? level)
                      (andmap (lambda (x) (even? x)) current-level)
                      (andmap (lambda (x) (odd? x)) current-level))
                  (andmap (lambda (a b) (< a b)) (append (reverse (take current-level (- (length current-level) 1))) (list (last current-level))) (append (reverse (take current-level (- (length current-level) 1))) (list (last current-level))))
                  (helper next-nodes (+ level 1))))]))
  (helper (list root) 0))