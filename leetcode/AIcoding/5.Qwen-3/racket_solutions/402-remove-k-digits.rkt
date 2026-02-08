(define (remove-k-digits num k)
  (define (helper stack i)
    (cond [(= i (string-length num)) (list->string stack)]
          [(and (> k 0) (not (null? stack)) (char<? (last stack) (string-ref num i)))
           (begin (set! k (- k 1)) (helper (reverse (cdr (reverse stack))) i))]
          [else (helper (append stack (list (string-ref num i))) (+ i 1))]))
  (define result (helper '() 0))
  (if (and (>= (string-length result) 1) (char=? #\0 (string-ref result 0)))
      (if (= (string-length result) 1) "0" (substring result 1 (string-length result)))
      result))