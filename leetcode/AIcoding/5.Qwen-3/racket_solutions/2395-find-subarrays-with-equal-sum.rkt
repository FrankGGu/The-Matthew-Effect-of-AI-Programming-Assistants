(define (find-subarrays nums)
  (define len (length nums))
  (define seen (make-hash))
  (for ([i (in-range (- len 1))])
    (define sum (+ (list-ref nums i) (list-ref nums (+ i 1))))
    (if (hash-has-key? seen sum)
        #t
        (hash-set! seen sum #t)))
  #f)