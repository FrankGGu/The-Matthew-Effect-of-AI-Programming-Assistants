#lang racket

(define (make-ordered-set)
  (let ([data '()]
        [index-map (hash)])
    (define (insert val)
      (set! data (cons val data))
      (hash-set! index-map val (length data)))
    (define (remove val)
      (when (hash-has-key? index-map val)
        (let ([idx (hash-ref index-map val)])
          (set! data (append (take data idx) (drop data (+ idx 1))))
          (for-each (lambda (k v)
                      (when (> v idx)
                        (hash-set! index-map k (- v 1))))
                    index-map)))
      #t)
    (define (get-random)
      (list-ref data (random (length data))))
    (define (dispatch m)
      (cond [(eq? m 'insert) insert]
            [(eq? m 'remove) remove]
            [(eq? m 'get-random) get-random]
            [else (error "Unknown method")]))
    dispatch))

(define (main)
  (let ([obj (make-ordered-set)])
    (obj 'insert 1)
    (obj 'insert 1)
    (obj 'insert 2)
    (obj 'remove 1)
    (obj 'get-random)
    (obj 'get-random)
    (obj 'get-random)))

(main)