(define (min-cost-override costs)
  (if (null? costs)
      0
      (let loop ((i 0) (prev (list 0 0 0)))
        (if (= i (length costs))
            (apply min prev)
            (loop (+ i 1) 
                  (list 
                   (+ (list-ref costs i) (list-ref prev 0))
                   (+ (list-ref costs i) (list-ref prev 1))
                   (+ (list-ref costs i) (list-ref prev 2))))))))

(define (min-cost colors)
  (min-cost-override colors))