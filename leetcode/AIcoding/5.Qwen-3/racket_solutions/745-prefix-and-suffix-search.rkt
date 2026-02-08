#lang racket

(define (make-hash)
  (let ([h (hash)])
    (lambda args
      (cond [(= (length args) 1) (hash-ref h (car args) #f)]
            [(= (length args) 2) (hash-set! h (car args) (cadr args))]
            [else (error "invalid number of arguments")]))))

(define (prefix-suffix-search words)
  (define (build-trie)
    (define trie (make-hash))
    (define (insert word index)
      (define (loop node prefix)
        (when (not (hash-has-key? node prefix))
          (hash-set! node prefix (make-hash)))
        (define next-node (hash-ref node prefix))
        (when (not (hash-has-key? next-node 'value))
          (hash-set! next-node 'value '()))
        (hash-set! next-node 'value (cons index (hash-ref next-node 'value)))
        (when (not (hash-has-key? next-node 'children))
          (hash-set! next-node 'children (make-hash)))
        (define children (hash-ref next-node 'children))
        (for-each (lambda (char)
                    (loop children char))
                  (string->list word)))
      (loop trie ""))
    (for ([i (in-range (length words))])
      (insert (list-ref words i) i))
    trie)

  (define (search prefix suffix)
    (define (get-words node prefix)
      (if (equal? prefix "")
          (if (hash-has-key? node 'value)
              (hash-ref node 'value)
              '())
          (let ([next-node (hash-ref node prefix #f)])
            (if next-node
                (get-words next-node (substring prefix 1))
                '()))))

    (define (filter-by-suffix words suffix)
      (filter (lambda (i)
                (and (<= (string-length (list-ref words i)) (string-length suffix))
                     (equal? (substring (list-ref words i) (- (string-length (list-ref words i))) 0)
                             (substring suffix (- (string-length suffix)) 0))))
              words))

    (define (get-all-words node)
      (if (hash-has-key? node 'value)
          (hash-ref node 'value)
          (for/fold ([result '()]) ([child (in-hash-values (hash-ref node 'children))])
            (append result (get-all-words child)))))

    (define all-words (get-all-words trie))
    (define prefix-words (get-words trie prefix))
    (define filtered-words (filter (lambda (i) (member i prefix-words)) all-words))
    (if (null? filtered-words)
        -1
        (apply max (filter-by-suffix words filtered-words))))

  (define trie (build-trie))
  (lambda (prefix suffix) (search prefix suffix)))

(define (main)
  (define words (list "apple" "banana" "cherry" "date" "elderberry" "fig" "grape"))
  (define search (prefix-suffix-search words))
  (displayln (search "a" "e")))

(main)