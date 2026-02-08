(define (orderly-queue s k)
  (if (= k 1)
      (let loop ((s s) (min-s s))
        (if (string=? s min-s)
            min-s
            (loop (string-append (substring s 1) (substring s 0 1))
                  (if (string<? s min-s) s min-s))))
      (list->string (sort (string->list s) char<?))))