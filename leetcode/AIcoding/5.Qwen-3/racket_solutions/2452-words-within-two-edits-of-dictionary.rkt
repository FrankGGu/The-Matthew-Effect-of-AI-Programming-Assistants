#lang racket

(define (in-dictionary word dict)
  (define (edit-distance s1 s2)
    (define (helper i j)
      (cond [(= i (string-length s1)) (- (string-length s2) j)]
            [(= j (string-length s2)) (- (string-length s1) i)]
            [(char=? (string-ref s1 i) (string-ref s2 j)) (helper (+ i 1) (+ j 1))]
            [else (+ 1 (min (helper (+ i 1) j)
                            (helper i (+ j 1))
                            (helper (+ i 1) (+ j 1))))]))
    (helper 0 0))
  (for/first ([d (in-list dict)] #:when (<= (edit-distance word d) 2))
    #t))

(define (two-edit-words queries dict)
  (filter (lambda (q) (in-dictionary q dict)) queries))