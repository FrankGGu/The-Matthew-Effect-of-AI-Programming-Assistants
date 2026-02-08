(define (lowest-common-ancestor root p q)
  (if (or (not root) (eq? root p) (eq? root q))
      root
      (let ((left (lowest-common-ancestor (car (cdr root)) p q))
            (right (lowest-common-ancestor (car (cdr (cdr root))) p q)))
        (if (and left right)
            root
            (if left left right)))))