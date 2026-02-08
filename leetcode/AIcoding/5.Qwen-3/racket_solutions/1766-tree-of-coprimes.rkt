#lang racket

(define (tree-of-coprimes n edges parent)
  (define-values (adj depth res)
    (let ([adj (make-hash)]
          [depth (make-vector n 0)]
          [res (make-vector n 0)])
      (for-each (lambda (e)
                  (let ([u (car e)] [v (cadr e)])
                    (hash-set! adj u (cons v (hash-ref adj u '())))
                    (hash-set! adj v (cons u (hash-ref adj v '())))))
                edges)
      (define (dfs u p d)
        (vector-set! depth u d)
        (for-each (lambda (v)
                    (when (not (= v p))
                      (dfs v u (+ d 1))))
                  (hash-ref adj u '()))
        (void))
      (dfs 0 -1 0)
      (values adj depth res)))

  (define coprimes (make-hash))
  (for ([i (in-range 1 1001)])
    (for ([j (in-range 1 1001)])
      (when (= (gcd i j) 1)
        (hash-set! coprimes i (cons j (hash-ref coprimes i '())))))

  (define (find-ancestor u v)
    (let loop ([u u] [v v])
      (cond [(= u v) u]
            [(> (vector-ref depth u) (vector-ref depth v)) (loop (hash-ref adj u (list -1)) v)]
            [else (loop u (hash-ref adj v (list -1)))])))

  (define (get-ancestor u v)
    (let loop ([u u] [v v])
      (cond [(= u v) u]
            [(> (vector-ref depth u) (vector-ref depth v)) (loop (hash-ref adj u (list -1)) v)]
            [else (loop u (hash-ref adj v (list -1)))])))

  (define (get-ancestor-with-value u val)
    (let loop ([u u])
      (if (= u -1)
          -1
          (if (= (vector-ref res u) val)
              u
              (loop (hash-ref adj u (list -1)))))))

  (define (solve)
    (for ([i (in-range n)])
      (let ([val (vector-ref parent i)])
        (let loop ([u i])
          (when (not (= u -1))
            (when (member (vector-ref parent u) (hash-ref coprimes val '()))
              (vector-set! res i u))
            (loop (hash-ref adj u (list -1))))))
      (when (= (vector-ref res i) 0)
        (vector-set! res i -1)))
    (vector->list res))

  (solve))