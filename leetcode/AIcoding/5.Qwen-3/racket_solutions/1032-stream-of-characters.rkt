#lang racket

(define (stream-of-characters)
  (define trie (hash))
  (define (insert word)
    (let loop ([node trie] [i 0])
      (when (< i (string-length word))
        (define c (string-ref word i))
        (when (not (hash-has-key? node c))
          (hash-set! node c (hash)))
        (loop (hash-ref node c) (+ i 1)))))
  (define (query s)
    (let loop ([node trie] [i 0])
      (if (> i (string-length s))
          #f
          (if (= i (string-length s))
              #t
              (begin
                (when (hash-has-key? node #\*) #t)
                (if (hash-has-key? node (string-ref s i))
                    (loop (hash-ref node (string-ref s i)) (+ i 1))
                    #f)))))
  (lambda (op . args)
    (match op
      ["insert" (insert (car args))]
      ["query" (query (car args))])))

(define (main)
  (define obj (stream-of-characters))
  (obj 'insert "abc")
  (obj 'insert "a")
  (obj 'insert "bc")
  (obj 'query "a")
  (obj 'query "b")
  (obj 'query "c")
  (obj 'query "ab")
  (obj 'query "bc")
  (obj 'query "abc")
  (obj 'query "abcd"))

(main)