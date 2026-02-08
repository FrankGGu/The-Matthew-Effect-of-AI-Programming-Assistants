#lang racket

(define (count-nodes-with-highest-score root)
  (define (dfs node)
    (if (not node)
        (values 0 0)
        (let* ([left (car node)]
               [right (cadr node)]
               [l-count l-subtree]
               [l-subtree (dfs left)]
               [r-count r-subtree]
               [r-subtree (dfs right)]
               [total (+ l-count r-count 1)])
          (values total (max (if (zero? l-count) 1 l-count) (if (zero? r-count) 1 r-count) (* (if (zero? l-count) 1 l-count) (if (zero? r-count) 1 r-count)))))))
  (define (get-score node)
    (if (not node)
        0
        (let* ([left (car node)]
               [right (cadr node)]
               [l-count l-subtree]
               [l-subtree (dfs left)]
               [r-count r-subtree]
               [r-subtree (dfs right)]
               [total (+ l-count r-count 1)])
          (max (if (zero? l-count) 1 l-count) (if (zero? r-count) 1 r-count) (* (if (zero? l-count) 1 l-count) (if (zero? r-count) 1 r-count)))))
  (define (count-max-scores node max-score)
    (if (not node)
        0
        (+ (if (= (get-score node) max-score) 1 0)
           (count-max-scores (car node) max-score)
           (count-max-scores (cadr node) max-score))))
  (let* ([total (dfs root)]
         [max-score (second total)])
    (count-max-scores root max-score)))