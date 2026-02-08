(define (delete-node node)
  (set-car! node (cadr node))
  (set-cdr! node (cddr node)))