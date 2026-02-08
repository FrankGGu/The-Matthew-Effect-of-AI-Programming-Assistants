(define (largest-odd-number s)
  (let loop ((i (- (string-length s) 1)) (result ""))
    (if (< i 0)
        result
        (let ((c (string-ref s i)))
          (if (and (char>=? c #\0) (char<=? c #\9) (odd? (- (char->integer c) (char->integer #\0))))
              (loop (- i 1) (string-append result (string c)))
              (loop (- i 1) result))))))