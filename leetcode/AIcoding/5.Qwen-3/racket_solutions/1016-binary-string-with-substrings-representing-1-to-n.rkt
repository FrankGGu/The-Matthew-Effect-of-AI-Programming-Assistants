(define (num-substrings s n)
  (let ((len (string-length s)))
    (let loop ((i 0) (seen (make-hash)))
      (if (>= i len)
          (hash-has-key? seen n)
          (let loop2 ((j (min (+ i 1) len)) (current 0))
            (if (>= j len)
                (loop (+ i 1) seen)
                (begin
                  (set! current (+ (* current 2) (- (char->integer (string-ref s j)) 48)))
                  (if (<= current n)
                      (begin
                        (hash-set! seen current #t)
                        (loop2 (+ j 1) current))
                      (loop (+ i 1) seen))))))))

(define (binary-string-with-substrings-representing-1-to-n s n)
  (num-substrings s n))