(define (distinct? s)
  (= (length (remove-duplicates (string->list s))) 3))

(define (count-unique-substrings s)
  (define len (string-length s))
  (if (< len 3)
      0
      (let loop ((i 0) (count 0))
        (if (>= i (- len 2))
            count
            (loop (+ i 1) (+ count (if (distinct? (substring s i (+ i 3))) 1 0)))))))

(count-unique-substrings s)