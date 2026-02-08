(define (odd-even-linked-list head)
  (if (or (null? head) (null? (cdr head)))
      head
      (let* ((odd-head (make-list 1 (car head)))
             (even-head (make-list 1 (cadr head)))
             (odd-tail odd-head)
             (even-tail even-head)
             (current (cddr head)))
        (let loop ((current current)
                   (is-odd #t))
          (when current
            (if is-odd
                (begin
                  (set-cdr! odd-tail (list (car current)))
                  (set! odd-tail (cdr odd-tail)))
                (begin
                  (set-cdr! even-tail (list (car current)))
                  (set! even-tail (cdr even-tail))))
            (loop (cdr current) (not is-odd))))
        (set-cdr! odd-tail even-head)
        odd-head)))