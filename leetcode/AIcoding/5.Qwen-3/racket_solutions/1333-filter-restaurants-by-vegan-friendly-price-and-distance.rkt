(define (filter-restaurants restaurants vegan-friendly max-price max-distance)
  (filter
   (lambda (r)
     (and (or (not vegan-friendly) (= (list-ref r 2) 1))
          (<= (list-ref r 3) max-price)
          (<= (list-ref r 4) max-distance)))
   restaurants))