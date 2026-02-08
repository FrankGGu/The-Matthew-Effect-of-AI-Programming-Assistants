(define (num-pairs-strings-with-concat target words)
  (define (count-pairs s)
    (let ((len (string-length s)))
      (if (< len 1) 0
          (let loop ((i 1) (cnt 0))
            (if (>= i len) cnt
                (let ((a (substring s 0 i))
                      (b (substring s i)))
                  (if (and (member a words) (member b words))
                      (loop (+ i 1) (+ cnt 1))
                      (loop (+ i 1) cnt)))))))
  (count-pairs target))