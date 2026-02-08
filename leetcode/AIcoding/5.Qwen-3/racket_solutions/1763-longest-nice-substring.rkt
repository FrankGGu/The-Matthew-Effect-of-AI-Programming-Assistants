#lang racket

(define (longest-nice-substring s)
  (define (is-nice? s)
    (define chars (string->list s))
    (for/and ([c chars])
      (and (member (char-upcase c) chars)
           (member (char-downcase c) chars))))
  (define (helper s start end)
    (if (> start end)
        ""
        (let ([sub (substring s start end)])
          (if (is-nice? sub)
              sub
              (let ([left (helper s start (- end 1))]
                    [right (helper s (+ start 1) end)])
                (if (> (string-length left) (string-length right))
                    left
                    right))))))
  (helper s 0 (string-length s)))