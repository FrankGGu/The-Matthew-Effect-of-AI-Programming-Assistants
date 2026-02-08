(define (check-duplicate? lst)
  (let ((seen (make-hash)))
    (for/and ([x lst])
      (if (hash-has-key? seen x)
          #f
          (begin (hash-set! seen x #t) #t)))))

(define (check-row row)
  (check-duplicate? row))

(define (check-column grid col-index)
  (let ((seen (make-hash)))
    (for/and ([row grid])
      (let ((val (list-ref row col-index)))
        (if (hash-has-key? seen val)
            #f
            (begin (hash-set! seen val #t) #t)))))

(define (valid-arrangement grid)
  (let ((n (length grid)))
    (andmap (lambda (i) (check-row (list-ref grid i))) (range n))
    (andmap (lambda (j) (check-column grid j)) (range n))))