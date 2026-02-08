(define (next-greater-element nums1 nums2)
  (define (helper nums2-map)
    (cond [(null? nums1) '()]
          [else
           (cons (hash-ref nums2-map (car nums1) -1)
                 (helper (cdr nums1)))]))
  (define nums2-map (make-hash))
  (define (build-map nums2)
    (cond [(null? nums2) #t]
          [else
           (hash-set! nums2-map (car nums2) -1)
           (build-map (cdr nums2))]))
  (build-map nums2)
  (define (process nums2)
    (cond [(null? nums2) #t]
          [else
           (let loop ([i (cdr nums2)] [current (car nums2)])
             (cond [(null? i) #t]
                   [(> (car i) current)
                    (hash-set! nums2-map current (car i))
                    (loop (cdr i) current)]
                   [else (loop (cdr i) current)]))])
  (process nums2)
  (helper nums1))