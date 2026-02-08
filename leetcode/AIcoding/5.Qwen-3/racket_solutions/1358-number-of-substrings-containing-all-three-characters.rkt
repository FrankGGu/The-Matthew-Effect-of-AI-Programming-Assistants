(define (number-of-substrings s)
  (define (count s c)
    (let loop ([i 0] [cnt 0] [last (make-hash)])
      (if (= i (string-length s))
          cnt
          (let ([ch (string-ref s i)])
            (if (hash-has-key? last ch)
                (loop (+ i 1) (+ cnt (- i (hash-ref last ch))) (hash-set last ch i))
                (loop (+ i 1) cnt (hash-set last ch i))))))
  )
  (let ([n (string-length s)])
    (if (< n 3)
        0
        (- (+ (* n (+ n 1)) 2) (* 3 (count s #\a)) (* 3 (count s #\b)) (* 3 (count s #\c)) (/ (* 3 (count s #\a) (count s #\b) (count s #\c)) 2)))))