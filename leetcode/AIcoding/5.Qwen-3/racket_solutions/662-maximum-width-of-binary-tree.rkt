#lang racket

(define (width-of-binary-tree root)
  (define (bfs node)
    (let ((queue (list (cons node 0))))
      (let loop ((queue queue) (max-width 0))
        (if (null? queue)
            max-width
            (let* ((current (car queue))
                   (node (car current))
                   (index (cdr current))
                   (next-queue (cdr queue)))
              (if (null? next-queue)
                  (loop '() (- index (car (reverse (map cdr queue))) 1))
                  (let ((left (and node (node-left node)))
                        (right (and node (node-right node))))
                    (loop (append next-queue
                                   (if left (list (cons left (+ index 1))) '())
                                   (max max-width (- (cadr (reverse (map cdr next-queue))) index 1))))))))))
  (if (null? root)
      0
      (bfs root)))