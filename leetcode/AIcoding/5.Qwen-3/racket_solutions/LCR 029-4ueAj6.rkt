(define-struct node (val next))
(define (insert head insertVal)
  (cond [(null? head) (make-node insertVal #f)]
        [else
         (let loop ([current head] [next (node-next head)] [prev head])
           (if (or (<= insertVal (node-val current)) (and (>= insertVal (node-val current)) (not (eqv? next current))))
               (begin
                 (set-node-next! prev (make-node insertVal next))
                 head)
               (if (eqv? next head)
                   (begin
                     (set-node-next! prev (make-node insertVal head))
                     head)
                   (loop next (node-next next) current))))]))