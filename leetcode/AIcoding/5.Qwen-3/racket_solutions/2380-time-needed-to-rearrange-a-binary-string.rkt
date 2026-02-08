(define (rearrange-string s)
  (define (count-chars s)
    (let loop ([s s] [zeros 0] [ones 0])
      (if (null? s)
          (cons zeros ones)
          (loop (cdr s) (+ zeros (if (char=? (car s) #\0) 1 0)) (+ ones (if (char=? (car s) #\1) 1 0))))))

  (define (time-needed zeros ones)
    (let loop ([i 0] [zeros zeros] [ones ones] [time 0])
      (if (>= i (min zeros ones))
          time
          (loop (+ i 1) (- zeros 1) (- ones 1) (+ time (* 2 i))))))

  (let* ([counts (count-chars s)]
         [zeros (car counts)]
         [ones (cdr counts)])
    (if (or (= zeros 0) (= ones 0))
        0
        (time-needed zeros ones)))
  )