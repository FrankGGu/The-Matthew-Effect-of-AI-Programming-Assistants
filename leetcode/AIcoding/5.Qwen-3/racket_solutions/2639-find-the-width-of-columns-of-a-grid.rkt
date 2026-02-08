(define (column-widths grid)
  (define (max-length row)
    (apply max (map string-length row)))
  (map max-length grid))