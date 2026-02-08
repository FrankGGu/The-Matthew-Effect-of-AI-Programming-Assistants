#lang racket

(define-struct cache-node (key value next prev))

(define (make-cache capacity)
  (let ([cache (make-hash)]
        [head (make-cache-node #f #f #f #f)]
        [tail (make-cache-node #f #f #f #f)]
        [size 0])
    (set-cdr! head tail)
    (set-cdr! tail head)
    (lambda (cmd . args)
      (cond
        [(eq? cmd 'get)
         (let ([key (car args)])
           (if (hash-has-key? cache key)
               (let ([node (hash-ref cache key)])
                 (let ([value (cache-node-value node)])
                   (when (not (eq? (cache-node-next node) tail))
                     (let ([next (cache-node-next node)]
                           [prev (cache-node-prev node)])
                       (set-cdr! prev next)
                       (set-cdr! next node)
                       (set-cdr! node next)
                       (set-cdr! prev node)))
                   value)
               -1))]
        [(eq? cmd 'put)
         (let ([key (car args)]
               [value (cadr args)])
           (if (hash-has-key? cache key)
               (begin
                 (let ([node (hash-ref cache key)])
                   (set-cache-node-value! node value)
                   (when (not (eq? (cache-node-next node) tail))
                     (let ([next (cache-node-next node)]
                           [prev (cache-node-prev node)])
                       (set-cdr! prev next)
                       (set-cdr! next node)
                       (set-cdr! node next)
                       (set-cdr! prev node))))
               (begin
                 (when (= size capacity)
                   (let ([old-node (cache-node-prev tail)])
                     (let ([prev (cache-node-prev old-node)])
                       (set-cdr! prev tail)
                       (set-cdr! tail old-node)
                       (hash-remove! cache (cache-node-key old-node))
                       (set! size (- size 1)))))
                 (let ([node (make-cache-node key value tail (cache-node-prev tail))])
                   (set-cdr! (cache-node-prev tail) node)
                   (set-cdr! tail node)
                   (hash-set! cache key node)
                   (set! size (+ size 1))))))])))

(define (LRUCache.ctor capacity)
  (make-cache capacity))

(define (LRUCache.get this key)
  ((this 'get) key))

(define (LRUCache.put this key value)
  ((this 'put) key value))