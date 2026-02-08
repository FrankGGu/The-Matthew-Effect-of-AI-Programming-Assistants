(define (num-jewels-in-stones jewels stones)
  (define jewel-set (list->set (string->list jewels)))
  (length (filter (lambda (c) (set-member? jewel-set c)) (string->list stones))))