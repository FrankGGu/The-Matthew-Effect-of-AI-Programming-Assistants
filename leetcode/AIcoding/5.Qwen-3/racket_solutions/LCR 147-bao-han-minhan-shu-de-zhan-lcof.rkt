(define-struct stack (data min-data))

(define (make-min-stack)
  (make-stack '() '()))

(define (push s x)
  (let ((current-min (if (null? (stack-min-data s))
                         x
                         (car (stack-min-data s)))))
    (make-stack (cons x (stack-data s))
                 (cons (min x current-min) (stack-min-data s)))))

(define (pop s)
  (make-stack (cdr (stack-data s))
               (cdr (stack-min-data s))))

(define (top s)
  (car (stack-data s)))

(define (get-min s)
  (car (stack-min-data s)))