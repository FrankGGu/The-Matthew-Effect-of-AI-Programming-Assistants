(define (repeated-string-match a b)
  (define (repeat s n)
    (if (= n 0)
        ""
        (string-append s (repeat s (- n 1)))))
  (let loop ((count 1) (current a))
    (if (string-contains? current b)
        count
        (if (> (string-length current) (* 2 (string-length b)))
            -1
            (loop (+ count 1) (string-append current a))))))