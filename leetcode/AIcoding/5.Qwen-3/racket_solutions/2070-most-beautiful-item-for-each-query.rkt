#lang racket

(define (sort-items items)
  (sort items (lambda (a b) (< (car a) (car b)))))

(define (max-beauty items query)
  (define sorted-items (sort-items items))
  (define (helper items max-b)
    (cond [(null? items) max-b]
          [else (helper (cdr items) (max max-b (cadr (car items))))]))
  (helper sorted-items 0))

(define (most-beautiful-item-for-each-query items queries)
  (define sorted-items (sort-items items))
  (define (binary-search target)
    (let loop ([low 0] [high (sub1 (length sorted-items))])
      (if (> low high)
          -1
          (let* ([mid (quotient (+ low high) 2)]
                 [price (caar (list-ref sorted-items mid))])
            (cond [(= price target) mid]
                  [(< price target) (loop (+ mid 1) high)]
                  [else (loop low (- mid 1))])))))
  (define (get-max-beauty index)
    (if (= index -1)
        0
        (let loop ([i index] [max-b 0])
          (if (>= i (length sorted-items))
              max-b
              (loop (+ i 1) (max max-b (cadr (list-ref sorted-items i))))))))
  (map (lambda (q)
         (let ([idx (binary-search q)])
           (get-max-beauty idx)))
       queries))