#lang racket

(define (semi-ordered-permutation arr)
  (define n (length arr))
  (define pos (make-hash))
  (for ([i (in-range n)])
    (hash-set! pos (list-ref arr i) i))
  (define (swap a b)
    (let ([x (list-ref arr a)]
          [y (list-ref arr b)])
      (vector-set! arr a y)
      (vector-set! arr b x)
      (hash-set! pos x b)
      (hash-set! pos y a)))
  (define (find k)
    (hash-ref pos k))
  (let loop ([i 0] [j (- n 1)] [count 0])
    (if (>= i j)
        count
        (let ([left (list-ref arr i)]
              [right (list-ref arr j)])
          (if (= left (add1 i))
              (loop (+ i 1) j count)
              (if (= right (sub1 j))
                  (loop i (- j 1) count)
                  (let ([k (find (add1 i))])
                    (swap i k)
                    (loop (+ i 1) j (+ count 1)))))))))