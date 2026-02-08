(define (distinct-difference-array nums)
  (define (count-diff nums)
    (let loop ([i 0] [prefix (hash)] [suffix (hash)])
      (if (= i (length nums))
          '()
          (let* ([current (list-ref nums i)]
                 [prefix-count (hash-update prefix current add1 0)]
                 [suffix-count (hash-update suffix current add1 0)]
                 [prefix-unique (hash-count (lambda (k v) (> v 0)) prefix-count)]
                 [suffix-unique (hash-count (lambda (k v) (> v 0)) suffix-count)]
                 [diff (- suffix-unique prefix-unique)])
            (cons diff (loop (+ i 1) prefix-count (hash-update suffix current add1 0)))))))
  (reverse (count-diff nums)))