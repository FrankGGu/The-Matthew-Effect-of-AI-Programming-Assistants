#lang racket

(define (smallest-string-starting-from-leaf root)
  (define (dfs node path)
    (if (not node)
        #f
        (let ([path (cons (integer->char (+ (car node) 97)) path)])
          (if (and (not (car node)) (not (cdr node)))
              (list->string path)
              (let ([left (dfs (cadr node) path)]
                    [right (dfs (caddr node) path)])
                (cond
                  [(and left right) (min left right)]
                  [left left]
                  [right right]
                  [else #f]))))))
  (dfs root '()))