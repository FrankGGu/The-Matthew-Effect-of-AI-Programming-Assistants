(define (is-legal-word? word order)
  (let loop ((i 0))
    (if (>= i (string-length word))
        #t
        (let ((current-char (string-ref word i)))
          (if (>= i (string-length order))
              #f
              (let ((order-index (string-index-of order current-char)))
                (if (and (< i (string-length word))
                         (not (equal? order-index #f)))
                    (let ((next-char (string-ref word (+ i 1))))
                      (let ((next-order-index (string-index-of order next-char)))
                        (if (and (not (equal? next-order-index #f))
                                 (<= order-index next-order-index))
                            (loop (+ i 1))
                            #f)))
                    #f)))))))

(define (string-index-of s c)
  (let loop ((i 0))
    (if (>= i (string-length s))
        #f
        (if (char=? (string-ref s i) c)
            i
            (loop (+ i 1)))))

(define (is-legal-dictionary words order)
  (let loop ((i 0))
    (if (>= i (length words))
        #t
        (let ((word (list-ref words i)))
          (if (not (is-legal-word? word order))
              #f
              (loop (+ i 1))))))

(define (valid-word-abbreviation words order)
  (is-legal-dictionary words order))