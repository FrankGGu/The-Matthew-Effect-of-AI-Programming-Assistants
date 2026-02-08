#lang racket

(define (replace-words dict sentence)
  (define trie (make-hash))
  (for-each
   (lambda (word)
     (define current trie)
     (for-each
      (lambda (c)
        (when (not (hash-has-key? current c))
          (hash-set! current c (make-hash)))
        (set! current (hash-ref current c)))
      (string->list word))
     (hash-set! current 'end #t))
   dict)
  (define (find-prefix word)
    (define current trie)
    (define prefix "")
    (for-each
     (lambda (c)
       (if (hash-has-key? current c)
           (begin
             (set! prefix (string-append prefix (string c)))
             (set! current (hash-ref current c))
             (when (hash-has-key? current 'end)
               (error (format "break ~a" prefix))))
           (error "break")))
     (string->list word))
    "")
  (define (process-word word)
    (with-handlers ([exn:fail:contract? (lambda (e) word)])
      (find-prefix word)
      ""))
  (string-join (map process-word (string-split sentence)) " "))

(define (main)
  (define input (read-line))
  (define dict (string-split input))
  (define sentence (read-line))
  (displayln (replace-words dict sentence)))

(main)