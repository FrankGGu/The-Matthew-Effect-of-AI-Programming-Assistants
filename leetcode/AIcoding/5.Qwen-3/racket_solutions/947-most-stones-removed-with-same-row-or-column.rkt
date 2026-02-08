(define (remove-stones stones)
  (define (find-parent x parent)
    (if (= (vector-ref parent x) x)
        x
        (let ([p (find-parent (vector-ref parent x) parent)])
          (vector-set! parent x p)
          p)))

  (define (union x y parent rank)
    (let ([xroot (find-parent x parent)]
          [yroot (find-parent y parent)])
      (when (not (= xroot yroot))
        (if (< (vector-ref rank xroot) (vector-ref rank yroot))
            (vector-set! parent xroot yroot)
            (begin
              (vector-set! parent yroot xroot)
              (when (= (vector-ref rank xroot) (vector-ref rank yroot))
                (vector-set! rank xroot (+ (vector-ref rank xroot) 1))))))))

  (define (max-connections stones)
    (define parent (make-vector (* 2 1000) 0))
    (define rank (make-vector (* 2 1000) 0))
    (for-each (lambda (i) (vector-set! parent i i)) (range (* 2 1000)))
    (for-each (lambda (s)
                (union (car s) (cadr s) parent rank))
              stones)
    (define (count-connected-components)
      (define visited (make-hash))
      (for-each (lambda (s)
                  (let ([x (car s)]
                        [y (cadr s)])
                    (hash-set! visited (find-parent x parent) #t)
                    (hash-set! visited (find-parent y parent) #t)))
                stones)
      (hash-count identity visited))
    (- (length stones) (count-connected-components)))

  (max-connections stones))