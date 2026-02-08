(define (tree-to-double-list root)
  (define (helper node)
    (if (not node)
        (values #f #f)
        (let* ((left (tree-to-double-list (car node)))
              (right (tree-to-double-list (cadr node)))
              (left-head (car left))
              (left-tail (cdr left))
              (right-head (car right))
              (right-tail (cdr right)))
          (if left-tail
              (begin
                (set-cdr! left-tail node)
                (set-car! node left-tail))
              (set-car! node #f))
          (if right-head
              (begin
                (set-car! right-head node)
                (set-cdr! node right-head))
              (set-cdr! node #f))
          (values (if left-head left-head node)
                  (if right-tail right-tail node)))))
  (car (helper root)))