#lang racket

(define (tag-validator s)
  (define (is-tag? c)
    (and (char>=? c #\A) (char<=? c #\Z)))

  (define (is-letter? c)
    (or (is-tag? c) (char=? c #\_)))

  (define (is-valid-tag? tag)
    (and (> (string-length tag) 0)
         (is-tag? (string-ref tag 0))
         (for/and ([c (in-string tag)])
           (is-letter? c))))

  (define (parse-tags s)
    (let loop ([s s] [stack '()])
      (cond [(string=? s "") (null? stack)]
            [(char=? (string-ref s 0) #\<)
             (if (char=? (string-ref s 1) #\/)
                 (let ([end (string-index s #\> 2)])
                   (if (and end (not (null? stack)))
                       (let ([tag (substring s 2 end)])
                         (if (equal? tag (car stack))
                             (loop (substring s (+ end 1)) (cdr stack))
                             #f))
                       #f))
                 (let ([end (string-index s #\> 1)])
                   (if end
                       (let ([tag (substring s 1 end)])
                         (if (is-valid-tag? tag)
                             (loop (substring s (+ end 1)) (cons tag stack))
                             #f))
                       #f)))]
            [else
             (loop (substring s 1) stack)]))

  (parse-tags s))

(define (string-index s c [start 0])
  (let loop ([i start])
    (cond [(= i (string-length s)) #f]
          [(char=? (string-ref s i) c) i]
          [else (loop (+ i 1))]))