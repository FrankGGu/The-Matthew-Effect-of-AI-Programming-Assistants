(define (swap-nodes head k)
  (define (get-length node)
    (if (not node)
        0
        (+ 1 (get-length (cdr node)))))

  (define (get-node node idx)
    (if (= idx 0)
        node
        (get-node (cdr node) (- idx 1))))

  (define len (get-length head))
  (define n (- len k))

  (define first (get-node head (- k 1)))
  (define second (get-node head n))

  (define (swap a b)
    (let ([a-val (car a)]
          [b-val (car b)])
      (set-car! a b-val)
      (set-car! b a-val)))

  (if (or (not first) (not second) (= k n))
      head
      (swap first second))

  head)