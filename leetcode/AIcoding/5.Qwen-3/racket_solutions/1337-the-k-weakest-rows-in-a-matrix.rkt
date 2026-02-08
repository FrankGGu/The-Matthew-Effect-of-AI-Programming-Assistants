#lang racket

(define (k-weakest-rows matrix k)
  (define (count-soldiers row)
    (let loop ([i 0] [count 0])
      (if (>= i (length row))
          count
          (if (= (list-ref row i) 1)
              (loop (+ i 1) (+ count 1))
              count))))

  (define sorted-rows
    (sort
     (for/list ([i (in-range (length matrix))])
       (cons i (count-soldiers (list-ref matrix i))))
     (lambda (a b)
       (if (= (cdr a) (cdr b))
           (< (car a) (car b))
           (< (cdr a) (cdr b))))))

  (take (map car sorted-rows) k))