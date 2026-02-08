#lang racket

(define (find-target root k)
  (define (inorder-traversal node)
    (if (not node)
        '()
        (append (inorder-traversal (node-left node))
                (list (node-val node))
                (inorder-traversal (node-right node)))))

  (define nums (inorder-traversal root))

  (define (two-sum lst target)
    (let loop ((i 0) (j (sub1 (length lst))))
      (cond ((>= i j) #f)
            ((= (+ (list-ref lst i) (list-ref lst j)) target) #t)
            ((< (+ (list-ref lst i) (list-ref lst j)) target) (loop (+ i 1) j))
            (else (loop i (- j 1))))))

  (two-sum nums k))