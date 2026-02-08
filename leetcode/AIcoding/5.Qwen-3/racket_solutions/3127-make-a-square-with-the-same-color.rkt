#lang racket

(define (square? s)
  (define (count-colors)
    (for/fold ([counts (hash)]) ([c s])
      (hash-update counts c add1 0)))
  (define colors (count-colors))
  (and (= (hash-count colors) 1)
       (>= (apply max (hash-values colors)) 4)))

(define (make-square s)
  (define len (string-length s))
  (for/or ([i (in-range len)])
    (for/or ([j (in-range i len)])
      (define sub (substring s i j))
      (when (square? sub)
        #t))))

  (if (make-square s) "Yes" "No"))