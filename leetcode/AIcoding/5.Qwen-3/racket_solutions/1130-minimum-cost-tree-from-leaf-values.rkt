#lang racket

(define (mct-bst nums)
  (define (helper l r)
    (if (>= l r)
        0
        (let ((min-cost 1000000))
          (for ([i (in-range l r)])
            (let* ((left (helper l i))
                   (right (helper (add1 i) r))
                   (current (* (list-ref nums l) (list-ref nums r))))
              (set! min-cost (min min-cost (+ left right current)))))
          min-cost)))
  (helper 0 (sub1 (length nums))))

(define (main)
  (define input (read-line))
  (define nums (map string->number (string-split input)))
  (display (mct-bst nums)))

(main)