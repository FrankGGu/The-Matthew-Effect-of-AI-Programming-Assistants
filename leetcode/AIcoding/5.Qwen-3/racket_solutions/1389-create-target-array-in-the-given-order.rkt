#lang racket

(define (insert-into-array)
  (let ([n (string->number (read-line))])
    (let loop ([i 0] [result '()])
      (if (>= i n)
          (reverse result)
          (let* ([val (string->number (list-ref (string-split (read-line)) 0))]
                 [index (string->number (list-ref (string-split (read-line)) 1))])
            (loop (+ i 1) (append (take result index) (list val) (drop result index))))))))

(insert-into-array)