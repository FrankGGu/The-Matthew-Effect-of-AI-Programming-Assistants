(define (distribute-candies candy-type)
  (let ((unique-candies (set! (make-set candy-type))))
    (min (length candy-type) (set-count unique-candies))))