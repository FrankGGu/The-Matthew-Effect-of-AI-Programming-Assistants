(define (max-chunks-to-make-sorted arr)
  (let loop ([i 0] [max-so-far 0] [count 0])
    (if (= i (length arr))
        count
        (let ([current (list-ref arr i)])
          (if (> current max-so-far)
              (loop (+ i 1) current (+ count 1))
              (loop (+ i 1) max-so-far count))))))