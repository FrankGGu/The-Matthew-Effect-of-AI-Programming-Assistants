(define (min-frogs-croaking croak)
  (define counts (make-hash))
  (define (get-count c)
    (hash-ref counts c 0))
  (define (set-count! c v)
    (hash-set! counts c v))
  (for-each
   (lambda (c)
     (cond
       [(char=? c #\c)
        (set-count! #\c (+ (get-count #\c) 1))]
       [(char=? c #\r)
        (set-count! #\r (+ (get-count #\r) 1))]
       [(char=? c #\o)
        (set-count! #\o (+ (get-count #\o) 1))]
       [(char=? c #\a)
        (set-count! #\a (+ (get-count #\a) 1))]
       [(char=? c #\k)
        (set-count! #\k (+ (get-count #\k) 1))]))
   (string->list croak))
  (let loop ([c #\c] [r #\r] [o #\o] [a #\a] [k #\k])
    (if (and (= (get-count #\c) (get-count #\r))
            (= (get-count #\r) (get-count #\o))
            (= (get-count #\o) (get-count #\a))
            (= (get-count #\a) (get-count #\k)))
        (get-count #\c)
        (let ([next (if (char=? c #\c) #\r (if (char=? c #\r) #\o (if (char=? c #\o) #\a (if (char=? c #\a) #\k #\c))))])
          (loop next r o a k)))))