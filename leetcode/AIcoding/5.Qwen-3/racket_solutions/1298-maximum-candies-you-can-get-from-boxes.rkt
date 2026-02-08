#lang racket

(define (max-candies candies boxes given toys)
  (define (get-boxes)
    (for/fold ([available '()]
               [has-key? #f]
               [key-count 0]
               [candy-count 0])
              ([box (in-list boxes)])
      (let* ([box-info (list-ref boxes box)]
             [box-id (car box-info)]
             [keys (cadr box-info)]
             [present (caddr box-info)])
        (if (or has-key? (member box-id given))
            (begin
              (set! has-key? #f)
              (set! key-count (+ key-count (length keys)))
              (set! candy-count (+ candy-count (list-ref candies box-id)))
              (if present
                  (set! key-count (+ key-count (length toys))))
              (values (append available (list box-id)) has-key? key-count candy-count))
            (values available has-key? key-count candy-count))))

  (define (process-boxes available key-count candy-count)
    (cond [(null? available) candy-count]
          [else
           (let* ([box-id (car available)]
                  [keys (cadr (list-ref boxes box-id))]
                  [present (caddr (list-ref boxes box-id))])
             (set! key-count (+ key-count (length keys)))
             (if present
                 (set! key-count (+ key-count (length toys))))
             (process-boxes (cdr available) key-count candy-count))]))

  (let-values ([(available has-key? key-count candy-count) (get-boxes)])
    (if has-key?
        (process-boxes available key-count candy-count)
        candy-count)))