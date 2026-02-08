(define (valid-path n edges source destination)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)])
                (hash-update! graph u (lambda (lst) (cons v lst)) '())
                (hash-update! graph v (lambda (lst) (cons u lst)) '())))
            edges)
  (define visited (make-hash))
  (define (dfs node)
    (if (= node destination)
        #t
        (begin
          (hash-set! visited node #t)
          (for/or ([neighbor (hash-ref graph node '())])
            (and (not (hash-has-key? visited neighbor))
                 (dfs neighbor)))))
  (dfs source))