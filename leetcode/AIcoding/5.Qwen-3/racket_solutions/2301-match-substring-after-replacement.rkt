#lang racket

(define (matches s1 s2 sub-replace-map)
  (define (get-replacement c)
    (hash-ref sub-replace-map c #f))

  (define (check i j)
    (cond [(= j (string-length s2)) #t]
          [(= i (string-length s1)) #f]
          [else
           (if (and (= (string-ref s1 i) (string-ref s2 j))
                    (check (+ i 1) (+ j 1)))
               #t
               (let ([replacement (get-replacement (string-ref s1 i))])
                 (if (and replacement (= (string-ref replacement 0) (string-ref s2 j)))
                     (check (+ i 1) (+ j 1))
                     #f)))]))

  (for/first ([i (in-range (string-length s1))])
    (when (check i 0) #t))
  #f)

(define (substring-match s1 s2 sub-replace-map)
  (matches s1 s2 sub-replace-map))