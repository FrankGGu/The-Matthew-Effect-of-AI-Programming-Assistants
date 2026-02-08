(define (digits-to-string n)
  (define (helper n res)
    (if (= n 0)
        res
        (helper (quotient n 10) (string-append (number->string (remainder n 10)) res))))
  (if (= n 0)
      "0"
      (helper n "")))

(define (thousand-separator n)
  (define s (digits-to-string n))
  (define len (string-length s))
  (define (add-separators i res)
    (if (< i 0)
        res
        (let ((res (string-append (substring s i (add1 i)) res)))
          (if (and (> i 0) (= (modulo (- len i) 3) 0))
              (add-separators (- i 1) (string-append "." res))
              (add-separators (- i 1) res)))))
  (add-separators (- len 1) ""))