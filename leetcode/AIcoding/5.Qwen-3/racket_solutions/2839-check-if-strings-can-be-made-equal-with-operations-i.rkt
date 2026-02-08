(define (can-convert s t)
  (let ([count-s (make-hash)]
        [count-t (make-hash)])
    (for-each (lambda (c) (hash-update! count-s c add1 0)) (string->list s))
    (for-each (lambda (c) (hash-update! count-t c add1 0)) (string->list t))
    (equal? count-s count-t)))