(define (longer-contiguous-segments-of-ones-than-zeros s)
  (define (count-segments s c)
    (let loop ([s s] [count 0] [max 0])
      (cond [(null? s) (max count max)]
            [(equal? (car s) c) (loop (cdr s) (+ count 1) max)]
            [else (loop (cdr s) 0 (max count max))])))
  (> (count-segments s #\1) (count-segments s #\0)))