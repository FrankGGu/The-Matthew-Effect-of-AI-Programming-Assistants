#lang racket

(define (has-path-sum root target)
  (define (helper node remaining)
    (cond [(not node) #f]
          [(and (not (car node)) (not (cadr node))) (= remaining (caddr node))]
          [else (or (helper (cadr node) (- remaining (caddr node)))
                    (helper (caddr node) (- remaining (caddr node))))]))
  (helper root target))

(define (path-sum root target)
  (define (helper node remaining path result)
    (cond [(not node) result]
          [(and (not (car node)) (not (cadr node)))
           (if (= remaining (caddr node))
               (cons (append path (list (caddr node))) result)
               result)]
          [else
           (let ([new-remaining (- remaining (caddr node))])
             (append
              (helper (cadr node) new-remaining (append path (list (caddr node))) result)
              (helper (caddr node) new-remaining (append path (list (caddr node))) result)))]))
  (helper root target '() '()))