#lang racket

(define (check-palindrome s)
  (define (helper i j)
    (or (>= i j)
        (and (= (string-ref s i) (string-ref s j))
             (helper (+ i 1) (- j 1)))))
  (helper 0 (- (string-length s) 1)))

(define (can-convert s t)
  (define len (string-length s))
  (define (helper i j)
    (cond [(> i j) #t]
          [(= (string-ref s i) (string-ref t j))
           (helper (+ i 1) (- j 1))]
          [else #f]))
  (helper 0 (- len 1)))

(define (split-strings-to-make-palindrome s t)
  (define len (string-length s))
  (define (check i)
    (and (check-palindrome (string-append (substring s 0 i) (substring t i len)))
         (check-palindrome (string-append (substring t 0 i) (substring s i len)))))
  (let loop ([i 0])
    (if (> i len)
        #f
        (if (check i)
            #t
            (loop (+ i 1))))))