(define (least-integer n tasks)
  (let ((count (make-hash)))
    (for-each (lambda (t) (hash-set! count t (+ 1 (hash-ref count t 0)))) tasks)
    (let ((max-count (apply max (hash-values count))))
      (+ (* (- max-count 1) (+ n 1)) (length (filter (lambda (v) (= v max-count)) (hash-values count)))))))

(define (task-scheduler tasks n)
  (least-integer n tasks))