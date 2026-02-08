#lang racket

(define (permute-unique nums)
  (define (backtrack path used)
    (if (= (length path) (length nums))
        (list path)
        (for/fold ([result '()])
                  ([i (in-range (length nums))])
          (if (or (equal? (list-ref nums i) (list-ref nums (sub1 i))) (list-ref used i))
              result
              (begin
                (vector-set! used i #t)
                (append result (backtrack (append path (list (list-ref nums i))) used)
                (vector-set! used i #f)
                )))))
  (define used (make-vector (length nums) #f))
  (sort (backtrack '() used) (lambda (a b) (andmap equal? a b))))