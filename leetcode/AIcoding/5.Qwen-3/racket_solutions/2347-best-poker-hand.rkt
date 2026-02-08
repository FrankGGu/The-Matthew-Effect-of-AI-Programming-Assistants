(define (best-poker-hand ranks suits)
  (define (count-freq lst)
    (let loop ((lst lst) (freq '()))
      (if (null? lst)
          freq
          (let ((key (car lst)))
            (loop (cdr lst)
                  (cons (cons key (length (filter (lambda (x) (= x key)) lst))) freq))))))

  (define (max-count lst)
    (apply max (map cdr lst)))

  (define rank-freq (count-freq ranks))
  (define suit-freq (count-freq suits))

  (cond ((>= (max-count suit-freq) 5) "Flush")
        ((>= (max-count rank-freq) 4) "Four of a Kind")
        ((>= (max-count rank-freq) 3) "Three of a Kind")
        ((>= (max-count rank-freq) 2) "Pair")
        (else "High Card")))