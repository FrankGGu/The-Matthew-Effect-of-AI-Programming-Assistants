#lang racket

(define (count-of-range-sum)
  (define (merge-sort arr low high)
    (when (> low high) '())
    (if (= low high)
        (list arr)
        (let* ([mid (quotient (+ low high) 2)]
               [left (merge-sort arr low mid)]
               [right (merge-sort arr (+ mid 1) high)]
               [merged (make-vector (- high low + 1))]
               [i 0]
               [j 0]
               [k 0])
          (let loop ()
            (when (< i (length left))
              (when (< j (length right))
                (if (<= (list-ref left i) (list-ref right j))
                    (begin
                      (vector-set! merged k (list-ref left i))
                      (set! i (+ i 1)))
                    (begin
                      (vector-set! merged k (list-ref right j))
                      (set! j (+ j 1)))))
            (when (< i (length left))
              (vector-set! merged k (list-ref left i))
              (set! i (+ i 1)))
            (when (< j (length right))
              (vector-set! merged k (list-ref right j))
              (set! j (+ j 1)))
            (set! k (+ k 1))
            (when (and (< i (length left)) (< j (length right)))
              (loop)))
          (vector->list merged))))

  (define (count-and-sort nums low high prefix)
    (if (> low high)
        0
        (let* ([mid (quotient (+ low high) 2)]
               [left-count (count-and-sort nums low mid prefix)]
               [right-count (count-and-sort nums (+ mid 1) high prefix)]
               [cross-count 0]
               [i low]
               [j mid + 1]
               [k low]
               [temp (make-vector (- high low + 1)])
               [sorted (merge-sort nums low high)])
          (set! cross-count 0)
          (set! i low)
          (set! j mid + 1)
          (set! k low)
          (let loop ()
            (when (< i mid + 1)
              (when (< j high + 1)
                (if (<= (list-ref nums i) (list-ref nums j))
                    (begin
                      (vector-set! temp k (list-ref nums i))
                      (set! i (+ i 1)))
                    (begin
                      (vector-set! temp k (list-ref nums j))
                      (set! j (+ j 1)))))
            (when (< i mid + 1)
              (vector-set! temp k (list-ref nums i))
              (set! i (+ i 1)))
            (when (< j high + 1)
              (vector-set! temp k (list-ref nums j))
              (set! j (+ j 1)))
            (set! k (+ k 1))
            (when (and (< i mid + 1) (< j high + 1))
              (loop)))
          (+ left-count right-count cross-count))))

  (define (main)
    (define nums (map string->number (string-split (read-line))))
    (define lower (string->number (read-line)))
    (define upper (string->number (read-line)))
    (define prefix (cons 0 (for/fold ([acc '()]) ([n nums]) (cons (+ (car acc) n) acc))))
    (define sorted-prefix (reverse (merge-sort (reverse prefix) 0 (- (length prefix) 1)))
    (define count (count-and-sort sorted-prefix 0 (- (length sorted-prefix) 1) prefix))
    (display count)
    (newline))

  (main))