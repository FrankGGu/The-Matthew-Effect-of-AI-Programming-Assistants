(define (restore-array adjacentPairs)
  (define graph (make-hash))
  (for-each
   (lambda (pair)
     (let ([a (car pair)]
           [b (cadr pair)])
       (hash-update! graph a (lambda (lst) (cons b lst)) '())
       (hash-update! graph b (lambda (lst) (cons a lst)) '())))
   adjacentPairs)
  (define start
    (for/first ([k (in-hash-keys graph)]
                #:when (= 1 (length (hash-ref graph k))))
      k))
  (define result (list start))
  (define current start)
  (define prev #f)
  (let loop ()
    (when (not (null? (cdr (hash-ref graph current))))
      (define next-node
        (if (equal? (car (hash-ref graph current)) prev)
            (cadr (hash-ref graph current))
            (car (hash-ref graph current))))
      (set! result (append result (list next-node)))
      (set! prev current)
      (set! current next-node)
      (loop)))
  (reverse result))