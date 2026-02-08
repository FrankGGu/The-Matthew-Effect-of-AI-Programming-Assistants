(define (categorize-box length width height mass)
  (define (is-integer? x)
    (= (floor x) x))
  (define volume (exact->inexact (* length width height)))
  (define heavy (>= mass 100))
  (define bulky (or (>= length 1000000)
                    (>= width 1000000)
                    (>= height 1000000)
                    (and (is-integer? (expt length 3)) (>= (expt length 3) 1000000000000))
                    (and (is-integer? (expt width 3)) (>= (expt width 3) 1000000000000))
                    (and (is-integer? (expt height 3)) (>= (expt height 3) 1000000000000))
                    (and (is-integer? volume) (>= volume 1000000000000))))
  (cond
    [(and bulky heavy) "Both"]
    [(and bulky (not heavy)) "Bulky"]
    [(and (not bulky) heavy) "Heavy"]
    [else "Neither"]))