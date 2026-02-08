(define (humidity-conditions seq)
  (let loop ((i 0) (prev 0) (count 0))
    (if (>= i (length seq))
        count
        (let ((current (list-ref seq i)))
          (if (and (>= current prev) (< (- current prev) 3))
              (loop (+ i 1) current (+ count 1))
              (loop (+ i 1) current 0))))))

(define (check-humidity seq)
  (let ((n (length seq)))
    (if (< n 2)
        0
        (let loop ((i 0) (max 0))
          (if (>= i (- n 1))
              max
              (let ((current (humidity-conditions (take seq (+ i 2)))))
                (loop (+ i 1) (max max current))))))))

(define (solve)
  (let ((input (read-line)))
    (printf "~a~n" (check-humidity (map string->number (string-split input))))))