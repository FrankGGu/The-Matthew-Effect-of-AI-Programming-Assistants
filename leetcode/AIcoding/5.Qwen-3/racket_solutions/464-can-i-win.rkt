#lang racket

(define (can-i-win max-integer desired-remaining)
  (define memo (make-hash))
  (define (dfs available nums)
    (if (hash-has-key? memo (cons available nums))
        (hash-ref memo (cons available nums))
        (let ([sum (apply + nums)])
          (if (>= sum desired-remaining)
              #t
              (let ([result #f])
                (for ([i (in-range 1 (add1 max-integer))])
                  (when (bitwise-and available (arithmetic-shift 1 i))
                    (set! result (not (dfs (bitwise-xor available (arithmetic-shift 1 i)) (append nums (list i)))))
                    (when result
                      (break)))
                (hash-set! memo (cons available nums) result)
                result)))))
  (dfs (sub1 (arithmetic-shift 1 max-integer)) '()))