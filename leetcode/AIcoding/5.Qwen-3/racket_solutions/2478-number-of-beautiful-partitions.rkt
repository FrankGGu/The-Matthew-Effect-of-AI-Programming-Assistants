#lang racket

(define (number-of-beautiful-partitions s k)
  (define n (string-length s))
  (define is-palindrome (make-hash))
  (define dp (make-hash))

  (define (is-palindrome? s i j)
    (cond [(< i 0) #f]
          [(> j (sub1 n)) #f]
          [(= i j) #t]
          [(and (= i (sub1 j)) (= (string-ref s i) (string-ref s j))) #t]
          [else
           (if (hash-has-key? is-palindrome (cons i j))
               (hash-ref is-palindrome (cons i j))
               (let ([res (= (string-ref s i) (string-ref s j))])
                 (hash-set! is-palindrome (cons i j) res)
                 res))]))

  (define (dfs i cnt)
    (cond [(> i (sub1 n)) (if (= cnt k) 1 0)]
          [(hash-has-key? dp (cons i cnt)) (hash-ref dp (cons i cnt))]
          [else
           (let ([res 0])
             (when (and (or (= i 0) (not (is-palindrome? s (sub1 i) (sub1 i))))
                        (is-palindrome? s i (sub1 n)))
               (set! res (+ res (dfs (add1 i) (add1 cnt)))))
             (when (and (not (is-palindrome? s (sub1 i) (sub1 i)))
                        (is-palindrome? s i (sub1 n)))
               (set! res (+ res (dfs (add1 i) cnt))))
             (hash-set! dp (cons i cnt) res)
             res)]))

  (if (or (= k 0) (and (= k 1) (is-palindrome? s 0 (sub1 n)))) 1 (dfs 0 0)))