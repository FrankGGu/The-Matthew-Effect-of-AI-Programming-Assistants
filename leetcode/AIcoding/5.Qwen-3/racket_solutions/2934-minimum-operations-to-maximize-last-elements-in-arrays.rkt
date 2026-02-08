#lang racket

(define (min-operations-to-maximize-last-elements nums1 nums2)
  (define (helper a b)
    (let loop ([i (sub1 (length a))] [op 0])
      (cond [(< i 0) op]
            [(= (list-ref a i) (list-ref b i)) (loop (sub1 i) op)]
            [else (loop (sub1 i) (add1 op))])))
  (let ([op1 (helper nums1 nums2)]
        [op2 (helper nums2 nums1)])
    (if (or (= op1 0) (= op2 0))
        (min op1 op2)
        (min op1 op2))))