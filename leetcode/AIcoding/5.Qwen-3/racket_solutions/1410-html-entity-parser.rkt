#lang racket

(define (entity-parser text)
  (define entities
    '((#\& . "&amp;")
      (#\> . "&gt;")
      (#\< . "&lt;")
      (#\&quot; . "\"")
      (#\&apos; . "'")))
  (define (parse-char c)
    (cond [(char=? c #\&) (string-append "&amp;" (parse-char (string-ref text (+ i 1))))]
          [(char=? c #\>) "&gt;"]
          [(char=? c #\<) "&lt;"]
          [(char=? c #\") "&quot;"]
          [(char=? c #\') "&apos;"]
          [else (string c)]))
  (define (loop i result)
    (if (>= i (string-length text))
        result
        (let ([c (string-ref text i)])
          (if (and (char=? c #\&)
                   (< (+ i 4) (string-length text))
                   (equal? (substring text i (+ i 6)) "&quot;")
                   (or (equal? (substring text i (+ i 6)) "&quot;")
                       (equal? (substring text i (+ i 6)) "&apos;")))
              (loop (+ i 6) (string-append result (cdr (assq (substring text i (+ i 6)) entities))))
              (if (and (char=? c #\&)
                       (< (+ i 4) (string-length text))
                       (equal? (substring text i (+ i 5)) "&gt;")
                       (equal? (substring text i (+ i 5)) "&lt;")
                       (equal? (substring text i (+ i 5)) "&amp;"))
                  (loop (+ i 5) (string-append result (cdr (assq (substring text i (+ i 5)) entities))))
                  (loop (+ i 1) (string-append result (parse-char c)))))))
  (loop 0 ""))