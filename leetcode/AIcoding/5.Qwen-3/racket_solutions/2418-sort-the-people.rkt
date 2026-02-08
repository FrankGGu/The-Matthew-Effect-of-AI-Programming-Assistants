(define (sort-people names heights)
  (map car (sort (map (lambda (name height) (list name height)) names heights) (lambda (a b) (> (cadr a) (cadr b))))))