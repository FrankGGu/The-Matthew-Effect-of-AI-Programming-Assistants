#lang racket

(define (max-ancestor-node root)
  (define (helper node max-so-far)
    (if (not node)
        0
        (let* ([current-val (node-val node)]
               [current-max (max max-so-far current-val)]
               [diff (- current-max current-val)])
          (max diff
               (helper (node-left node) current-max)
               (helper (node-right node) current-max)))))
  (helper root -inf.0))