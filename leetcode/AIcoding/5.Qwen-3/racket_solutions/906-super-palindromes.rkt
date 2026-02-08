#lang racket

(define (is-palindrome? s)
  (equal? s (reverse s)))

(define (to-string n)
  (number->string n))

(define (sqrt-int n)
  (exact-floor (sqrt n)))

(define (super-palindromes)
  (define result '())
  (define (add-if-palindrome x)
    (when (and (<= x 1000000000000000000)
               (is-palindrome? (to-string x)))
      (set! result (cons x result))))

  (let loop ((i 1))
    (when (<= i 100000)
      (let ((s (to-string i)))
        (when (is-palindrome? s)
          (let ((p (string->number (string-append s (substring s 0 (sub1 (string-length s)))))))
            (add-if-palindrome p)
            (add-if-palindrome (* p p))
            (when (even? (string-length s))
              (add-if-palindrome (string->number (string-append s (substring s 0 (quotient (string-length s) 2))))))
            (add-if-palindrome (string->number (string-append s (substring s 0 (quotient (string-length s) 2)))))
            (add-if-palindrome (string->number (string-append s (substring s 0 (quotient (string-length s) 2)))))
            (add-if-palindrome (string->number (string-append s (substring s 0 (quotient (string-length s) 2))))))))
      (loop (add1 i))))

  (sort (remove-duplicates result) <))

(define (main)
  (define limit (read))
  (define res (super-palindromes))
  (displayln (length res)))

(main)