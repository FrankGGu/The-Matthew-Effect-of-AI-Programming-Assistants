(define (longest-happy-string a b c)
  (define (helper a b c res)
    (cond [(and (= a 0) (= b 0) (= c 0)) res]
          [(or (> a 0) (> b 0) (> c 0))
           (let* ([max-char (if (> a b) (if (> a c) #\a #\c) (if (> b c) #\b #\c))]
                  [count (case max-char
                           [#\a a]
                           [#\b b]
                           [#\c c])])
             (if (and (>= count 2)
                      (or (and (char=? (string-ref res (- (string-length res) 1)) max-char)
                               (char=? (string-ref res (- (string-length res) 2)) max-char)))
                  (let ([next-char (if (char=? max-char #\a) (if (> b c) #\b #\c)
                                      (if (char=? max-char #\b) (if (> a c) #\a #\c)
                                          (if (> a b) #\a #\b)))])
                    (if (and (> (case next-char
                                 [#\a a]
                                 [#\b b]
                                 [#\c c]) 0))
                        (helper (- a (if (char=? next-char #\a) 1 0))
                                (- b (if (char=? next-char #\b) 1 0))
                                (- c (if (char=? next-char #\c) 1 0))
                                (string-append res (string next-char)))
                        res))
                  (helper (- a (if (char=? max-char #\a) 1 0))
                          (- b (if (char=? max-char #\b) 1 0))
                          (- c (if (char=? max-char #\c) 1 0))
                          (string-append res (string max-char)))))]
          [else res]))
  (helper a b c ""))