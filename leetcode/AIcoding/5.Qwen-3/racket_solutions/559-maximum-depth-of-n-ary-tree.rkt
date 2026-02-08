#lang racket

(define (max-depth root)
  (if (not root)
      0
      (+ 1 (apply max (map max-depth (node-children root))))))