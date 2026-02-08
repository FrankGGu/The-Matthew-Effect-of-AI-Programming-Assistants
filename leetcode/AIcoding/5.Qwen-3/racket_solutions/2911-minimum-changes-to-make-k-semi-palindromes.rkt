#lang racket

(define (min-changes-to-make-k-semi-palindromes s k)
  (define n (string-length s))
  (define (is-palindrome? s)
    (equal? s (reverse s)))

  (define (get-substrings s)
    (for/list ([i (in-range (string-length s))])
      (for/list ([j (in-range i (string-length s))])
        (substring s i (add1 j)))))

  (define (min-changes s)
    (define len (string-length s))
    (define dp (make-vector len (vector len 0)))
    (for ([i (in-range len)])
      (vector-set! dp i (vector i 0)))

    (for ([i (in-range len)])
      (for ([j (in-range i len)])
        (when (is-palindrome? (substring s i (add1 j)))
          (vector-set! dp j (vector i 0))))

    (for ([j (in-range len)])
      (for ([i (in-range j)])
        (when (not (equal? (vector-ref dp i) (vector i 0)))
          (define cost (+ (vector-ref dp i 1) (if (is-palindrome? (substring s (vector-ref dp i 0) (add1 j))) 0 1)))
          (when (< cost (vector-ref dp j 1))
            (vector-set! dp j (vector (vector-ref dp i 0) cost)))))

    (vector-ref dp (sub1 len) 1))

  (define substrings (get-substrings s))
  (define m (length substrings))
  (define dp (make-vector (add1 k) (vector m 0)))
  (for ([i (in-range (add1 k))])
    (vector-set! dp i (vector m 0)))

  (for ([i (in-range 1 (add1 k))])
    (for ([j (in-range m)])
      (for ([l (in-range j)])
        (when (<= (string-length (list-ref substrings l)) (string-length (list-ref substrings j)))
          (define cost (+ (vector-ref dp (sub1 i) l) (min-changes (list-ref substrings j))))
          (when (< cost (vector-ref dp i j))
            (vector-set! dp i j (vector l cost))))))

  (vector-ref dp k (sub1 m) 1))