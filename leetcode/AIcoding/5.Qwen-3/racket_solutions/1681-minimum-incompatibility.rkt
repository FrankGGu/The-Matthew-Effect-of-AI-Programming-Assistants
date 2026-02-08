#lang racket

(define (min-incompatibility nums max-incompatibility)
  (define n (length nums))
  (define k (quotient n 2))
  (define target (apply + nums))
  (define dp (make-hash))
  (define (dfs idx mask)
    (cond [(= idx k) 0]
          [(hash-has-key? dp mask) (hash-ref dp mask)]
          [else
           (define res #inf.0)
           (define first (if (= idx 0) 0 (bitwise-and (arithmetic-shift mask -1) #b11111111)))
           (for ([i (in-range 0 n)])
             (when (bitwise-bit-set? mask i)
               (define new-mask (bitwise-xor mask (arithmetic-shift 1 i)))
               (define current (list-ref nums i))
               (define sum-current (apply + (filter (lambda (x) (bitwise-bit-set? new-mask x)) nums)))
               (when (and (not (bitwise-bit-set? mask i))
                          (<= sum-current max-incompatibility))
                 (define next-res (dfs (add1 idx) new-mask))
                 (when (not (nan? next-res))
                   (set! res (min res (+ (abs (- sum-current target)) next-res))))))
           (hash-set! dp mask (if (nan? res) #inf.0 res))
           (hash-ref dp mask)]))
  (if (even? n) (dfs 0 (bitwise-not 0)) #inf.0))