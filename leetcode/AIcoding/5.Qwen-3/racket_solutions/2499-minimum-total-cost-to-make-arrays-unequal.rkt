#lang racket

(define (min-total-cost nums)
  (define n (length nums))
  (define freq (make-hash))
  (for-each (lambda (x) (hash-set! freq x (+ 1 (hash-ref freq x 0)))) nums)
  (define-values (max-freq max-val)
    (for/fold ([max-freq 0] [max-val 0]) ([k (in-hash-keys freq)])
      (define cnt (hash-ref freq k))
      (if (> cnt max-freq)
          (values cnt k)
          (values max-freq max-val))))
  (if (= max-freq (floor (/ n 2)))
      0
      (- (* 2 max-freq) n)))

(define (main)
  (define input (current-input-port))
  (define nums (map string->number (string-split (port->string input))))
  (display (min-total-cost nums)))

(main)