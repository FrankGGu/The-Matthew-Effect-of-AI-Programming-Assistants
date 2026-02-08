(define (vowel-strings? s)
  (let ([first (string-ref s 0)]
        [last (string-ref s (- (string-length s) 1))])
    (and (or (char=? first #\a) (char=? first #\e) (char=? first #\i) (char=? first #\o) (char=? first #\u))
         (or (char=? last #\a) (char=? last #\e) (char=? last #\i) (char=? last #\o) (char=? last #\u)))))

(define (count-vowel-strings words left right)
  (define (helper i count)
    (if (> i right)
        count
        (helper (+ i 1) (if (vowel-strings? (list-ref words i)) (+ count 1) count))))
  (helper left 0))