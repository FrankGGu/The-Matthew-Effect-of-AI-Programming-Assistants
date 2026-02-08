#lang racket

(define/contract (find-maximum-profit n k capitals profits)
  (-> exact-integer? exact-integer? (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define-struct project (capital profit) #:transparent)
  (define projects (map (lambda (c p) (make-project c p)) capitals profits))
  (define sorted-projects (sort projects (lambda (a b) (< (project-capital a) (project-capital b)))))
  (define heap (make-heap #<))
  (define current-capital 0)
  (define index 0)
  (define (add-projects)
    (when (and (< index n) (<= (project-capital (list-ref sorted-projects index)) current-capital))
      (heap-add! heap (project-profit (list-ref sorted-projects index)))
      (set! index (+ index 1))
      (add-projects))
    (void))
  (define (select-project)
    (if (heap-empty? heap)
        #f
        (heap-remove! heap)))
  (let loop ([count 0] [current-capital current-capital])
    (if (= count k)
        current-capital
        (begin
          (add-projects)
          (let ([selected (select-project)])
            (if selected
                (loop (+ count 1) (+ current-capital selected))
                current-capital)))))
  (void))