(define (is-legal-word word order)
  (define order-map (for/hash ((c order)) (values c (string-length order))))
  (define (compare a b)
    (cond
      [(= (hash-ref order-map a) (hash-ref order-map b)) #t]
      [else (< (hash-ref order-map a) (hash-ref order-map b))]))
  (let loop ((prev #f) (words (string-split word " ")))
    (cond
      [(null? words) #t]
      [(not prev) (loop (car words) (cdr words))]
      [else
       (if (and (<= (string-length prev) (string-length (car words)))
                (for/and ((i (in-range (string-length prev))))
                  (compare (string-ref prev i) (string-ref (car words) i)))
                (or (= (string-length prev) (string-length (car words)))
                    (and (> (string-length (car words)) (string-length prev))
                         (for/and ((i (in-range (string-length prev))))
                           (compare (string-ref prev i) (string-ref (car words) i)))))
           (loop (car words) (cdr words))
           #f))]))

(define (is-alien-sorted words order)
  (is-legal-word (string-join words " ") order))