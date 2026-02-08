(define-struct stack (data min-stack))

(define (make-min-stack) (stack '() '()))

(define (push s val)
  (let* ([current-min (if (null? (stack-min-stack s)) val (car (stack-min-stack s)))]
         [new-min (if (< val current-min) val current-min)])
    (stack (cons val (stack-data s)) (cons new-min (stack-min-stack s)))))

(define (pop s)
  (stack (cdr (stack-data s)) (cdr (stack-min-stack s))))

(define (top s)
  (car (stack-data s)))

(define (get-min s)
  (car (stack-min-stack s)))