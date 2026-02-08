#lang racket

(define-struct trie-node (children is-end))

(define (make-trie) (make-trie-node (hash) #f))

(define (add-word root word)
  (define (helper node idx)
    (if (= idx (string-length word))
        (set-trie-node-is-end! node #t)
        (let ([c (string-ref word idx)])
          (if (hash-has-key? (trie-node-children node) c)
              (helper (hash-ref (trie-node-children node) c) (+ idx 1))
              (begin
                (hash-set! (trie-node-children node) c (make-trie-node (hash) #f))
                (helper (hash-ref (trie-node-children node) c) (+ idx 1))))))
  (helper root 0))

(define (search-word root word)
  (define (helper node idx)
    (cond
      [(= idx (string-length word)) (trie-node-is-end? node)]
      [else
       (let ([c (string-ref word idx)])
         (if (char=? c #\.)
             (for/or ([child (in-hash-values (trie-node-children node))])
               (helper child (+ idx 1)))
             (if (hash-has-key? (trie-node-children node) c)
                 (helper (hash-ref (trie-node-children node) c) (+ idx 1))
                 #f)))]))
  (helper root 0))

(define (main)
  (define root (make-trie))
  (add-word root "bad")
  (add-word root "dad")
  (add-word root "mad")
  (displayln (search-word root "pad")) ; #f
  (displayln (search-word root "b..")) ; #t
  (displayln (search-word root "m..")) ; #t
  (displayln (search-word root "....")) ; #f)

(main)