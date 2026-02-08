#lang racket

(define (max-repeating-string s word)
  (define (check k)
    (let loop ((i 0))
      (cond ((>= i (- (string-length s) (* k (string-length word)))) #f)
            ((equal? (substring s i (+ i (string-length word))) word)
             (loop (+ i (string-length word))))
            (else (loop (+ i 1))))))

  (let loop ((low 0) (high (quotient (string-length s) (string-length word))))
    (if (> low high)
        0
        (let ((mid (quotient (+ low high) 2)))
          (if (check mid)
              (loop (+ mid 1) high)
              (loop low (- mid 1)))))))

(define (maximum-repeating-substring s word)
  (max-repeating-string s word))