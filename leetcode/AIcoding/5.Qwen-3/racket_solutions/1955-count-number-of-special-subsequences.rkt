(define (count-special-subsequences strs)
  (define MOD 1000000007)
  (define (count str)
    (let ((a 0) (ab 0) (abc 0))
      (for-each
       (lambda (c)
         (cond
           [(char=? c #\a) (set! a (modulo (+ a 1) MOD))]
           [(char=? c #\b) (set! ab (modulo (+ ab a) MOD))]
           [(char=? c #\c) (set! abc (modulo (+ abc ab) MOD))]))
       (string->list str))
      abc))
  (apply + (map count strs)))