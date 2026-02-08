(define (count-segments s)
  (length (filter (lambda (x) (not (string=? x ""))) (string-split s #\ ))))