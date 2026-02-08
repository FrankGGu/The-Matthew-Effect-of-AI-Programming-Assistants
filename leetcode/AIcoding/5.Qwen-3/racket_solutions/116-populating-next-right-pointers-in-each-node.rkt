(define-struct node (val left right next) #:mutable)

(define (connect root)
  (if (not root)
      #f
      (begin
        (let loop ((current root))
          (when current
            (when (node-left current)
              (set-node-right! (node-left current) (node-right current)))
            (loop (node-right current))))
        (connect (node-left root))
        (connect (node-right root))
        root)))