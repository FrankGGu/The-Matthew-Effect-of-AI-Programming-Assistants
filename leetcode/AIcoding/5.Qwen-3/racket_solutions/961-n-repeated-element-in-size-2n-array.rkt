(define (repeated-element nums)
  (let ([seen (make-hash)])
    (for/first ([num nums]
                #:when (hash-has-key? seen num))
      num)
    (for-each (lambda (num) (hash-set! seen num #t)) nums)))