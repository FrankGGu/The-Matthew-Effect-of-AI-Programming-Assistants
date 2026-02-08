#lang racket

(define (max-operations nums)
  (define (count-ops target)
    (let loop ([i 0] [count 0])
      (if (>= i (- (length nums) 1))
          count
          (if (= (+ (list-ref nums i) (list-ref nums (+ i 1))) target)
              (loop (+ i 2) (+ count 1))
              (loop (+ i 1) count)))))
  (define (max-ops)
    (let ([n (length nums)])
      (if (< n 2)
          0
          (let ([a (list-ref nums 0)]
                [b (list-ref nums 1)])
            (let ([target1 (+ a b)]
                  [target2 (+ a (list-ref nums 2))])
              (max (count-ops target1) (count-ops target2)))))))
  (max-ops))