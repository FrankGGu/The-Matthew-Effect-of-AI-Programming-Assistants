(define (roman-to-integer s)
  (define roman-map
    (hash #\I 1 #\V 5 #\X 10 #\L 50 #\C 100 #\D 500 #\M 1000))
  (define (helper s total)
    (if (string=? s "")
        total
        (let* ((current (hash-ref roman-map (string-ref s 0)))
               (next (if (> (string-length s) 1)
                         (hash-ref roman-map (string-ref s 1))
                         0)))
          (if (>= next current)
              (helper (substring s 1) (- total current))
              (helper (substring s 1) (+ total current))))))
  (helper s 0))