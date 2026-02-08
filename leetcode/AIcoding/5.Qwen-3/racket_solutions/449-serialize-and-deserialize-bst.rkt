#lang racket

(define (serialize root)
  (define (helper node res)
    (if (not node)
        res
        (begin
          (set! res (append res (list (number->string (node-val node)))))
          (helper (node-left node) res)
          (helper (node-right node) res))))
  (string-join (helper root '()) " "))

(define (deserialize data)
  (if (string=? data "")
      #f
      (let ((nums (map string->number (string-split data))))
        (define (build i j)
          (if (> i j)
              #f
              (let ((root (make-node (list-ref nums i) #f #f)))
                (define left (build (+ i 1) (find-index nums (list-ref nums i) i j)))
                (set-node-left! root left)
                (define right (build (add1 (if left (node-right-index root) i)) j))
                (set-node-right! root right)
                root)))
        (define (find-index nums val start end)
          (let loop ((i start))
            (if (> i end)
                -1
                (if (< (list-ref nums i) val)
                    (loop (+ i 1))
                    i))))
        (build 0 (- (length nums) 1))))

(define-struct node (val left right) #:mutable)

(define (make-node val left right)
  (make-node val left right))