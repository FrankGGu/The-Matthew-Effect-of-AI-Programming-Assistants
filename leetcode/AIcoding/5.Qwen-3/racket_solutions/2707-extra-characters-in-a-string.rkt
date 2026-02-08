#lang racket

(define (longest-beautiful-substring s)
  (define (is-beautiful? s)
    (and (regexp-match? #rx"^[aeiou]+$" s)
         (regexp-match? #rx"a.*e.*i.*o.*u" s)))
  (define (helper s start)
    (if (>= start (string-length s))
        0
        (let loop ([end (add1 start)])
          (if (> end (string-length s))
              0
              (let ([sub (substring s start end)])
                (if (is-beautiful? sub)
                    (max (string-length sub) (loop (add1 end)))
                    (loop (add1 end))))))))
  (let loop ([i 0] [max-len 0])
    (if (= i (string-length s))
        max-len
        (loop (add1 i) (max max-len (helper s i))))))