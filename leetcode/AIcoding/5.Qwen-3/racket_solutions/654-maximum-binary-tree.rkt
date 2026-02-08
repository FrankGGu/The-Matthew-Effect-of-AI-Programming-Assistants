#lang racket

(define (construct-maximum-binary-tree nums)
  (define (build nums start end)
    (when (< start end)
      (let ((max-index (argmax (lambda (i) (list-ref nums i)) (range start end))))
        (list 'TreeNode (list-ref nums max-index)
              (build nums start max-index)
              (build nums (+ max-index 1) end)))))
  (build nums 0 (length nums)))