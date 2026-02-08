#lang racket

(define (flatten root)
  (let loop ([root root])
    (when root
      (loop (TreeNode-left root))
      (loop (TreeNode-right root))
      (let ([left (TreeNode-left root)])
        (when left
          (set-TreeNode-right! root left)
          (let loop ([node left])
            (when (TreeNode-right node)
              (loop (TreeNode-right node)))
            (set-TreeNode-right! node (TreeNode-right root))))))))