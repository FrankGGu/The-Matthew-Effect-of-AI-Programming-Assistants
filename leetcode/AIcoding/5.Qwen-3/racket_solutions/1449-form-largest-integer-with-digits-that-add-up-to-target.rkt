#lang racket

(define (largest-integer-with-digits-that-add-up-to-target target)
  (define digits '(9 8 7 6 5 4 3 2 1))
  (define (dfs remaining)
    (cond [(zero? remaining) ""]
          [(negative? remaining) ""]
          [else
           (for/fold ([best ""]) ([d digits])
             (define s (dfs (- remaining d)))
             (if (and (not (string=? s "")) (or (string=? best "") (> (string-length s) 0)))
                 (string-append (number->string d) s)
                 best))]))
  (define result (dfs target))
  (if (string=? result "") "0" result))