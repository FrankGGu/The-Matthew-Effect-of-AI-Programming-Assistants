(define (longest-possible-string a b c)
  (define (helper x y z)
    (if (or (zero? x) (zero? y) (zero? z))
        0
        (let* ((max-char (max x y z))
               (other1 (if (= x max-char) y x))
               (other2 (if (= z max-char) y z)))
          (+ 2 (helper (- max-char 1) other1 other2)))))
  (helper a b c))