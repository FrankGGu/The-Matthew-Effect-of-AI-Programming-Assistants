(define (minimum-sum num)
  (define digits (sort (map (lambda (c) (- (char->integer c) 48)) (string->list (number->string num))) <))
  (+ (* 10 (car digits)) (* 10 (cadr digits)) (+ (caddr digits) (cadddr digits))))