(define (decode-integer s)
  (define (helper s res)
    (if (null? s)
        res
        (let ((c (car s)))
          (if (char-numeric? c)
              (helper (cdr s) (+ (* res 10) (- (char->integer c) 48)))
              (helper (cdr s) res)))))
  (helper (string->list s) 0))