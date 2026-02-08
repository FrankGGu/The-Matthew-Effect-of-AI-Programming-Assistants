#lang racket

(define (tree-highest-level root)
  (if (null? root)
      0
      (let ((left (tree-highest-level (car (cdr root))))
            (right (tree-highest-level (car (cdr (cdr root))))))
        (+ 1 (max left right)))))

(define (count-nodes root)
  (if (null? root)
      0
      (+ 1 (count-nodes (car (cdr root))) (count-nodes (car (cdr (cdr root)))))))

(define (is-complete-tree root)
  (define (helper queue)
    (cond
      [(null? queue) #t]
      [(null? (car queue)) #t]
      [else
       (let ((node (car queue)))
         (if (or (null? (car (cdr node))) (null? (car (cdr (cdr node)))))
             (and (null? (car (cdr node))) (null? (car (cdr (cdr node))))
                  (for/and ([n (in-list (cdr queue))]) (null? (car (cdr n))) (null? (car (cdr (cdr n))))))
             (helper (append (cdr queue) (list (car (cdr node)) (car (cdr (cdr node)))))))]))
  (helper (list root)))

(define (number-of-light-strings root)
  (if (null? root)
      0
      (let ((height (tree-highest-level root))
            (count (count-nodes root)))
        (if (is-complete-tree root)
            (- (* 2 height) 1)
            (let ((full-levels (floor (log count 2))))
              (+ full-levels 1))))))