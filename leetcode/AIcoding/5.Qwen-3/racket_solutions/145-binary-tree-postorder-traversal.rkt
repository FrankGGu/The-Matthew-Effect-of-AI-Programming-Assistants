(define (postorder-traversal root)
  (define (helper node result)
    (if (not node)
        result
        (begin
          (helper (TreeNode-left node) result)
          (helper (TreeNode-right node) result)
          (set! result (cons (TreeNode-val node) result))
          result)))
  (reverse (helper root '())))