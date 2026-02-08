(define (count-components head G)
  (define G-set (list->set G))
  (define (helper node prev)
    (cond
      [(not node) 0]
      [else
       (if (and (set-member? G-set (node-val node)) (not (set-member? G-set (node-val prev))))
           (+ 1 (helper (node-next node) (node-val node)))
           (helper (node-next node) (node-val node)))]))
  (if (not head) 0 (helper head #f)))