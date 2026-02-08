(define (prefix-suffix-pairs nums)
  (define (count-pairs lst)
    (let loop ([lst lst] [count 0])
      (if (null? lst)
          count
          (let ([s (car lst)])
            (loop (cdr lst) (+ count (length (filter (lambda (t) (and (string-prefix? s t) (string-suffix? s t))) (cdr lst)))))))))
  (count-pairs nums))