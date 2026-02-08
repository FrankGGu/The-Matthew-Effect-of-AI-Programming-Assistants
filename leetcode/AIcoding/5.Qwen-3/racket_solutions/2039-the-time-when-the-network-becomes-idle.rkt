#lang racket

(define (max-depth root)
  (if (not root)
      0
      (add1 (max (max-depth (car root)) (max-depth (cadr root))))))

(define (time-to-finish root)
  (define (helper node depth)
    (if (not node)
        0
        (let ([left (helper (car node) (add1 depth))]
              [right (helper (cadr node) (add1 depth))])
          (max left right))))
  (helper root 0))

(define (network-idle-time n edges startNode)
  (define graph (make-hash))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)])
       (hash-set! graph u (cons v (hash-ref graph u '())))
       (hash-set! graph v (cons u (hash-ref graph v '())))))
   edges)
  (define visited (make-hash))
  (define (bfs queue depth)
    (cond [(null? queue) 0]
          [else
           (let* ([current (caar queue)]
                  [next (cdar queue)]
                  [new-queue (append next (filter (lambda (x) (not (hash-has-key? visited x))) (hash-ref graph current)))]
                  [new-visited (hash-set visited current #t)])
             (if (null? new-queue)
                 (sub1 depth)
                 (bfs new-queue (add1 depth))))]))
  (bfs (list (cons startNode '())) 0))

(define (main)
  (define input (read-line))
  (define n (string->number input))
  (define edges (map (lambda (s) (map string->number (string-split s))) (take (for/list ([i (- n 1)]) (read-line)) n)))
  (define startNode (string->number (read-line)))
  (define max-depth (max-depth (list (list '() '()))))
  (define time (time-to-finish (list (list '() '()))))
  (define result (network-idle-time n edges startNode))
  (display result)
  (newline))

(main)