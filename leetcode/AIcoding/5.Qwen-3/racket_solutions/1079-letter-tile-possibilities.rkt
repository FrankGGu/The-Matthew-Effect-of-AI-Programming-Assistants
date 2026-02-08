(define (num-tiles-possibilities tiles)
  (define freq (make-hash))
  (for ([c tiles])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define (dfs)
    (let loop ([freq freq] [count 0])
      (if (null? (hash->list freq))
          count
          (let* ([keys (hash-keys freq)]
                 [key (car keys)]
                 [val (hash-ref freq key)])
            (let ([new-freq (hash-copy freq)])
              (hash-set! new-freq key (- val 1))
              (if (= val 1)
                  (loop (hash-remove new-freq key) (+ count 1))
                  (loop new-freq (+ count 1)))
              (loop freq (+ count (dfs))))))))
  (dfs))