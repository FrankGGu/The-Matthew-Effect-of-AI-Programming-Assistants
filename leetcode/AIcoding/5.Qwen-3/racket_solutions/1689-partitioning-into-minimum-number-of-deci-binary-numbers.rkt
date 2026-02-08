(define (min-number-of-deci-binary-numbers n)
  (apply max (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list n))))