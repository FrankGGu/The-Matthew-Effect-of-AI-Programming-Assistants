(define (reverse-list head)
  (define (iter prev curr)
    (if (null? curr)
        prev
        (let ((next (cdr curr)))
          (set-cdr! curr prev)
          (iter curr next))))
  (iter '() head))