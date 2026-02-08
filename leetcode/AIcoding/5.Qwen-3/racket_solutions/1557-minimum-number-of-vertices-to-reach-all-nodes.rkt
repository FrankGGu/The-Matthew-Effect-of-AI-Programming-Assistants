(define (find-vertices n edges)
  (define in-degree (make-vector n 0))
  (for-each (lambda (edge)
              (vector-set! in-degree (cadr edge) (+ (vector-ref in-degree (cadr edge)) 1)))
            edges)
  (for/list ([i (in-range n)]
             #:when (= (vector-ref in-degree i) 0))
    i))