#lang racket

(define-struct: TreeNode ([val : Integer] [left : (U TreeNode #f)] [right : (U TreeNode #f)]))

(define (insertIntoBST root val)
  (if (not root)
      (make-TreeNode val #f #f)
      (let ([current-root root])
        (if (< val (TreeNode-val current-root))
            (make-TreeNode (TreeNode-val current-root)
                           (insertIntoBST (TreeNode-left current-root) val)
                           (TreeNode-right current-root))
            (make-TreeNode (TreeNode-val current-root)
                           (TreeNode-left current-root)
                           (insertIntoBST (TreeNode-right current-root) val))))))