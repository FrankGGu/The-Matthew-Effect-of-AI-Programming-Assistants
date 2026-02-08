#lang racket

(define (pseudo-palindromic-paths root)
  (define (dfs node path)
    (if (not node)
        0
        (let ([new-path (cons (node-val node) path)])
          (if (and (not (node-left node)) (not (node-right node)))
              (if (valid-palindrome? new-path) 1 0)
              (+ (dfs (node-left node) new-path)
                 (dfs (node-right node) new-path)))))
    )
  )

  (define (valid-palindrome? lst)
    (define (count-odds lst)
      (define (helper lst count)
        (cond [(null? lst) count]
              [(even? (count (car lst))) (helper (cdr lst) count)]
              [else (helper (cdr lst) (+ count 1))]))
      (helper lst 0))

    (let ([odds (count-odds lst)])
      (or (= odds 0) (= odds 1)))
    )
  )

  (dfs root '())
)