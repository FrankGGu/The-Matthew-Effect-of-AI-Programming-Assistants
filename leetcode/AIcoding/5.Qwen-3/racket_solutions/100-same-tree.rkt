#lang racket

(define-struct: TreeNode (val left right) #:mutable)

(define (isSameTree p q)
  (cond [(and (not p) (not q)) #t]
        [(or (not p) (not q)) #f]
        [else (and (= (TreeNode-val p) (TreeNode-val q))
                   (isSameTree (TreeNode-left p) (TreeNode-left q))
                   (isSameTree (TreeNode-right p) (TreeNode-right q)))]))