(define (is-acronym words s)
  (and (= (length words) (string-length s))
       (for/and ([w words] [c s])
         (= (string-length w) (- (char->integer c) (char->integer #\a) 1)))))