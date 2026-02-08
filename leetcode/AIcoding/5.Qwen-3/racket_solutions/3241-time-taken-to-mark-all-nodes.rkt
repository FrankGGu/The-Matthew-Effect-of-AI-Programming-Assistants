#lang racket

(define (time-to-mark-nodes root)
  (define (dfs node parent)
    (if (not node)
        (values 0 0)
        (let* ([left (dfs (node-left node) node)]
               [right (dfs (node-right node) node)]
               [left-time (car left)]
               [left-count (cadr left)]
               [right-time (car right)]
               [right-count (cadr right)])
          (let ([total-time (+ left-time right-time (if (not parent) 0 (max left-time right-time)))]
                [total-count (+ left-count right-count 1)])
            (values total-time total-count)))))
  (car (dfs root #f)))