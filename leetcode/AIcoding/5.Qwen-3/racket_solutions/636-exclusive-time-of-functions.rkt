(define (exclusive-time n logs)
  (define stack (list))
  (define res (make-vector n 0))
  (define (parse-log log)
    (let* ([parts (string-split log ",")]
           [id (string->number (car parts))]
           [type (cadr parts)]
           [time (string->number (caddr parts))])
      (cons id (cons type time))))
  (for-each
   (lambda (log)
     (let* ([parsed (parse-log log)]
            [id (car parsed)]
            [type (cadr parsed)]
            [time (caddr parsed)])
       (if (equal? type "start")
           (begin
             (when (not (null? stack))
               (let* ([prev (car stack)]
                      [prev-id (car prev)]
                      [prev-time (caddr prev)])
                 (vector-set! res prev-id (- time prev-time))))
             (set! stack (cons (cons id (cons type time)) stack)))
           (begin
             (let* ([top (car stack)]
                    [top-id (car top)]
                    [top-type (cadr top)]
                    [top-time (caddr top)])
               (vector-set! res top-id (+ (vector-ref res top-id) (- time top-time 1)))
               (set! stack (cdr stack))))))
   logs)
  (vector->list res))