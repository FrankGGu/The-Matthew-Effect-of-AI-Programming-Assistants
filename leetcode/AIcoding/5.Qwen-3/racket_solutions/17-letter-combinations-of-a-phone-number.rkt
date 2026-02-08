(define (letter-combinations digits)
  (define mapping
    (hash #\2 "abc" #\3 "def" #\4 "ghi" #\5 "jkl" #\6 "mno" #\7 "pqrs" #\8 "tuv" #\9 "wxyz"))
  (define (helper remaining result)
    (if (null? remaining)
        (if (null? result) '() result)
        (let ((current (hash-ref mapping (car remaining))))
          (apply append
                 (map (lambda (char)
                        (helper (cdr remaining) (append result (list char))))
                      (string->list current)))))
  (if (equal? digits "")
      '()
      (helper (string->list digits) '())))