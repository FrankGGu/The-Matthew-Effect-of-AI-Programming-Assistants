(define-struct stock-spanner (stack))

(define (make-stock-spanner)
  (make-stock-spanner '()))

(define (next spanner price)
  (let loop ([s (stock-spanner-stack spanner)]
             [count 1])
    (if (null? s)
        (begin
          (set-stock-spanner-stack! spanner (cons (cons price count) s))
          count)
        (let ([top-price (caar s)])
          (if (> top-price price)
              (begin
                (set-stock-spanner-stack! spanner (cons (cons price count) s))
                count)
              (loop (cdr s) (+ count (cdar s))))))))