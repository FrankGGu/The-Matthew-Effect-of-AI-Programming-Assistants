(define (advantage-count A B)
  (define (sort-with-index lst)
    (map (lambda (i x) (list x i)) (range (length lst)) lst))

  (define sorted-A (sort A <))
  (define sorted-B (sort (sort-with-index B) (lambda (a b) (< (car a) (car b)))))

  (define (find-advantage)
    (let loop ((a sorted-A) (b sorted-B) (result '()))
      (if (null? a)
          result
          (let ((a-val (car a))
                (b-val (caar b)))
            (if (>= a-val b-val)
                (loop (cdr a) (cdr b) (append result (list (cadar b))))
                (loop (cdr a) (cons (car b) (cdr b)) (append result (list (cadar b))))))))

  (define result (find-advantage))
  (define index-map (for/hash ((i (in-range (length B))) (val (in-list result))) (values val i)))
  (map (lambda (x) (hash-ref index-map x)) A))