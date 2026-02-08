(define (min-swaps-arrays a b)
  (define len (length a))
  (define (swap x y) (values y x))
  (define (get i) (values (list-ref a i) (list-ref b i)))
  (define (set!-a i v) (set! a (append (take a i) (list v) (drop a (+ i 1)))))
  (define (set!-b i v) (set! b (append (take b i) (list v) (drop b (+ i 1)))))
  (let loop ([i 1] [no-swap 0] [swap 0])
    (cond [(= i len) (min no-swap swap)]
          [else
           (let* ([a-i (list-ref a i)] [b-i (list-ref b i)]
                  [a-prev (list-ref a (- i 1))] [b-prev (list-ref b (- i 1))])
             (if (and (< a-prev a-i) (< b-prev b-i))
                 (loop (+ i 1) no-swap swap)
                 (if (and (< a-prev b-i) (< b-prev a-i))
                     (loop (+ i 1) (+ no-swap 1) (min swap no-swap))
                     (if (and (> a-prev a-i) (> b-prev b-i))
                         (loop (+ i 1) (+ swap 1) no-swap)
                         (loop (+ i 1) (min no-swap (+ swap 1)) (+ no-swap 1))))))])))