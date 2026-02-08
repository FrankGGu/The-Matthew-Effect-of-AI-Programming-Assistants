(define (is-sum-equal a b c)
  (define (word-to-num word)
    (define (char-to-digit c)
      (- (char->integer c) (char->integer #\a)))
    (let loop ([i 0] [num 0])
      (if (= i (string-length word))
          num
          (loop (+ i 1) (+ (* num 10) (char-to-digit (string-ref word i)))))))
  (= (+ (word-to-num a) (word-to-num b)) (word-to-num c)))