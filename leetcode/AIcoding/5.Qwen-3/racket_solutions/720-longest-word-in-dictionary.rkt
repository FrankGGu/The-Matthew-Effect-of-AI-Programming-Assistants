#lang racket

(define (longest-word-in-dictionary words)
  (define (trie-node)
    (hash 'children (hash) 'is-end #f))

  (define (insert-word trie word)
    (define (loop node idx)
      (if (= idx (string-length word))
          (hash-set node 'is-end #t)
          (let* ([char (string-ref word idx)]
                 [child (hash-ref (hash-ref node 'children) char #f)])
            (if child
                (loop child (+ idx 1))
                (let ([new-child (trie-node)])
                  (hash-set! (hash-ref node 'children) char new-child)
                  (loop new-child (+ idx 1)))))))
    (loop trie 0))

  (define (dfs node prefix)
    (define max-word (if (hash-ref node 'is-end #f) prefix ""))
    (for/fold ([best max-word]) ([char (in-hash-keys (hash-ref node 'children))])
      (define child (hash-ref (hash-ref node 'children) char))
      (define next-prefix (string-append prefix (string char)))
      (define sub-word (dfs child next-prefix))
      (if (> (string-length sub-word) (string-length best))
          sub-word
          best)))

  (define trie (trie-node))
  (for-each (lambda (word) (insert-word trie word)) words)
  (dfs trie ""))

(define (main)
  (define input (read-line))
  (define words (map (lambda (s) (substring s 1 (- (string-length s) 1))) (string-split input #\,)))
  (displayln (longest-word-in-dictionary words)))

(main)