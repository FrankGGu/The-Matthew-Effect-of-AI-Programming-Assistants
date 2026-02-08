(define (lexicographically-smallest-string s)
  (define (min-char s)
    (let loop ([i 0] [min-c #\z])
      (if (= i (string-length s))
          min-c
          (loop (+ i 1) (min min-c (string-ref s i))))))
  (define (find-first-index s c)
    (let loop ([i 0])
      (if (= i (string-length s))
          -1
          (if (char=? (string-ref s i) c)
              i
              (loop (+ i 1))))))
  (let* ([min-c (min-char s)]
         [pos (find-first-index s min-c)])
    (if (= pos -1)
        s
        (string-append (substring s 0 pos) (substring s (+ pos 1))))))

(define (main)
  (let ([input (read-line)])
    (display (lexicographically-smallest-string input))))

(main)