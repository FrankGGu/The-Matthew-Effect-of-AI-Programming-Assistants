(define (partition-head head val)
  (let loop ([current head] [prev #f])
    (if (not current)
        (values head #f)
        (if (<= (car current) val)
            (loop (cdr current) current)
            (let-values ([(new-head new-prev) (partition-head (cdr current) val)])
              (if new-prev
                  (begin
                    (set-cdr! new-prev (cons (car current) (cdr new-prev)))
                    (values new-head prev))
                  (begin
                    (set-cdr! current new-head)
                    (values current prev))))))))

(define (partition head val)
  (let-values ([(new-head _) (partition-head head #f)])
    new-head))