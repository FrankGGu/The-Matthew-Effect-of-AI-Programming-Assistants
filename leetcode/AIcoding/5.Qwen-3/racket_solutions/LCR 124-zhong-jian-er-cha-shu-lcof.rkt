#lang racket

(define (tree->list tree)
  (if (null? tree)
      '()
      (append (tree->list (cadr tree))
              (list (car tree))
              (tree->list (caddr tree)))))

(define (list->tree lst)
  (if (null? lst)
      '()
      (let* ((mid (quotient (length lst) 2))
             (root (list (list-ref lst mid))))
        (set-car! root (list (list-ref lst mid)))
        (set-cdr! root (list (list->tree (take lst mid))
                             (list->tree (drop lst (add1 mid))))))))

(define (get-target-root tree target)
  (cond ((null? tree) #f)
        ((= (car tree) target) tree)
        (else (or (get-target-root (cadr tree) target)
                  (get-target-root (caddr tree) target)))))

(define (is-subtree bigger smaller)
  (cond ((null? smaller) #t)
        ((null? bigger) #f)
        ((equal? (tree->list bigger) (tree->list smaller)) #t)
        (else (or (is-subtree (cadr bigger) smaller)
                  (is-subtree (caddr bigger) smaller)))))

(define (get-path-to-node tree target)
  (define (helper node path)
    (cond ((null? node) #f)
          ((= (car node) target) (reverse path))
          (else (let ((left (helper (cadr node) (cons (car node) path))))
                  (if left
                      left
                      (helper (caddr node) (cons (car node) path)))))))
  (helper tree '()))

(define (get-ancestor tree node)
  (define (helper node path)
    (cond ((null? node) #f)
          ((equal? node (car path)) (reverse (cdr path)))
          (else (let ((left (helper (cadr node) (cons (car node) path))))
                  (if left
                      left
                      (helper (caddr node) (cons (car node) path)))))))
  (helper tree '()))

(define (get-deepest-node tree)
  (define (helper node depth)
    (if (null? node)
        (cons 0 #f)
        (let* ((left (helper (cadr node) (+ depth 1)))
               (right (helper (caddr node) (+ depth 1)))
               (max-depth (max (car left) (car right)))
               (deepest-node (if (= (car left) max-depth)
                                 (cadr left)
                                 (cadr right))))
          (cons max-depth deepest-node))))
  (cadr (helper tree 0)))

(define (get-children tree node)
  (define (helper node path)
    (cond ((null? node) #f)
          ((equal? node (car path)) (list (cadr node) (caddr node)))
          (else (let ((left (helper (cadr node) (cons (car node) path))))
                  (if left
                      left
                      (helper (caddr node) (cons (car node) path)))))))
  (helper tree '()))

(define (get-sibling tree node)
  (define (helper node path)
    (cond ((null? node) #f)
          ((equal? node (car path)) (if (null? (cddr path))
                                        #f
                                        (if (equal? (cadr path) node)
                                            (caddr path)
                                            (cadr path))))
          (else (let ((left (helper (cadr node) (cons (car node) path))))
                  (if left
                      left
                      (helper (caddr node) (cons (car node) path)))))))
  (helper tree '()))