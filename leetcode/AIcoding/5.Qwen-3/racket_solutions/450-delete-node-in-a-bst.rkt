(define-struct node (val left right))

(define (delete-node root key)
  (cond
    [(not root) #f]
    [(= (node-val root) key)
     (cond
       [(not (node-left root)) (node-right root)]
       [(not (node-right root)) (node-left root)]
       [else
        (let ((min-node (find-min (node-right root))))
          (set-node-val! root (node-val min-node))
          (set-node-right! root (delete-node (node-right root) (node-val min-node)))
          root)])]
    [(< key (node-val root))
     (set-node-left! root (delete-node (node-left root) key))
     root]
    [else
     (set-node-right! root (delete-node (node-right root) key))
     root]))

(define (find-min node)
  (if (node-left node)
      (find-min (node-left node))
      node))