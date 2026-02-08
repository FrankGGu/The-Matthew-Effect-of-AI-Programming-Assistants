#lang racket

(define (num-matching-subseq s words)
  (define (char->index c)
    (- (char->integer c) (char->integer #\a)))

  (define (build-trie)
    (let ([root (make-hash)])
      (for ([word words])
        (let loop ([node root] [i 0])
          (when (< i (string-length word))
            (define c (string-ref word i))
            (define idx (char->index c))
            (when (not (hash-has-key? node idx))
              (hash-set! node idx (make-hash)))
            (loop (hash-ref node idx) (+ i 1)))))
      root))

  (define (count-matches trie)
    (define (dfs node pos)
      (if (>= pos (string-length s))
          0
          (let ([count 0])
            (when (hash-has-key? node -1)
              (set! count (+ count (hash-ref node -1))))
            (for ([i (in-range 26)])
              (when (hash-has-key? node i)
                (define next-pos (string-index s (integer->char (+ i (char->integer #\a))) pos))
                (when next-pos
                  (set! count (+ count (dfs (hash-ref node i) (+ next-pos 1))))))
            count)))
    (dfs trie 0))

  (define trie (build-trie))
  (count-matches trie))