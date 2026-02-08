#lang racket

(define (short-encoding-of-words words)
  (define trie (make-hash))
  (define (insert word)
    (define (loop node i)
      (if (= i (string-length word))
          #t
          (let ([char (string-ref word i)])
            (if (hash-has-key? node char)
                (loop (hash-ref node char) (+ i 1))
                (begin
                  (hash-set! node char (make-hash))
                  (loop (hash-ref node char) (+ i 1))))))
    (loop trie 0))

  (define (is-suffix word)
    (define (loop node i)
      (if (= i (string-length word))
          #t
          (let ([char (string-ref word i)])
            (if (hash-has-key? node char)
                (loop (hash-ref node char) (+ i 1))
                #f))))
    (loop trie 0))

  (define (count-lengths)
    (define (dfs node depth)
      (if (and (hash-empty? node) (> depth 0))
          depth
          (for/sum ([v (in-hash-values node)])
            (dfs v (+ depth 1)))))
    (dfs trie 0))

  (for-each insert words)
  (count-lengths))