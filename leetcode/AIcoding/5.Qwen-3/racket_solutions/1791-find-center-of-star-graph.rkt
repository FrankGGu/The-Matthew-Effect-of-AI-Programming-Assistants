(define/contract (find-center edges)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let ([e1 (car edges)]
        [e2 (cadr edges)])
    (if (= (car e1) (car e2))
        (car e1)
        (if (= (car e1) (cadr e2))
            (car e1)
            (cadr e1)))))