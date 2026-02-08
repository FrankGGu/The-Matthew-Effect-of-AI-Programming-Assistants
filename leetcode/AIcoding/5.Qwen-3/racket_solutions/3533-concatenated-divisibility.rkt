#lang racket

(define (get-divisors n)
  (define (iter i res)
    (if (> i (sqrt n))
        res
        (if (= (modulo n i) 0)
            (iter (+ i 1) (append res (list i) (if (= i (/ n i)) '() (list (/ n i)))))
            (iter (+ i 1) res))))
  (sort (iter 1 '()) <))

(define (solve nums)
  (define len (length nums))
  (define divisors (get-divisors len))
  (define (check s)
    (let loop ((i 0) (sum 0))
      (if (= i len)
          (and (not (= sum 0)) (= (modulo sum len) 0))
          (loop (+ i 1) (+ sum (string->number (substring s i (+ i 1))))))))
  (define (backtrack path idx)
    (cond ((= idx len) (if (check path) 1 0))
          (else
           (for/sum ((d (in-list divisors)))
             (if (and (<= d (expt 10 (- len idx))) (not (member d (map string->number (string-split path " ")))))
                 (backtrack (string-append path (number->string d) " ") (+ idx 1))
                 0))))
  (backtrack "" 0))