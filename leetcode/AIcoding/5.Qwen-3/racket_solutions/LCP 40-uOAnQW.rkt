(define (sum-numbers s)
  (define (helper i acc)
    (if (>= i (string-length s))
        acc
        (let ((c (string-ref s i)))
          (if (char-numeric? c)
              (helper (+ i 1) (+ acc (- (char->integer c) (char->integer #\0))))
              (helper (+ i 1) acc)))))
  (helper 0 0))