(define (most-frequent-even-element nums)
  (define freq (make-hash))
  (for-each (lambda (n)
              (when (even? n)
                (hash-set! freq n (+ 1 (hash-ref freq n 0)))))
            nums)
  (cond ((hash-empty? freq) #f)
        (else
         (let loop ([max-count 0] [result -1] [keys (hash-keys freq)])
           (if (null? keys)
               result
               (let* ([key (car keys)]
                      [count (hash-ref freq key)])
                 (if (> count max-count)
                     (loop count key (cdr keys))
                     (loop max-count result (cdr keys))))))))