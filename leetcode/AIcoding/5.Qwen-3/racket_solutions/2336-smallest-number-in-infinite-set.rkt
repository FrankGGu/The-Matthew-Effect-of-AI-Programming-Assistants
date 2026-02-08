(define-struct set ()
  #:transparent)

(define (make-smallest-infinite-set)
  (let ((current 1))
    (lambda ()
      (let ((val current))
        (set! current (+ current 1))
        val))))