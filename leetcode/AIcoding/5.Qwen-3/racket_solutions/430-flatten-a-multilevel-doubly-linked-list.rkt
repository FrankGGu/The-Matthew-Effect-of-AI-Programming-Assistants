(define-struct node (val prev next children))
(define (flatten head)
  (define (flatten-helper current)
    (if (not current)
        #f
        (let loop ((current current) (prev #f))
          (let ((next (node-next current)))
            (if (node-children current)
                (let* ((child (node-children current))
                       (new-next (flatten-helper child)))
                  (set-node-next! current new-next)
                  (when new-next
                    (set-node-prev! new-next current))
                  (loop new-next current))
                (begin
                  (set-node-children! current #f)
                  (if prev
                      (begin
                        (set-node-next! prev current)
                        (set-node-prev! current prev))
                      (set-node-prev! current #f))
                  (loop next current))))))
  (flatten-helper head)
  head)