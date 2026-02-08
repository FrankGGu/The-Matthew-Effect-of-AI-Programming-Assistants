(define (shortest-completing-word license-plate words)
  (define (count-chars s)
    (let loop ([s s] [counts (make-hash)])
      (if (null? s)
          counts
          (let ([c (char-downcase (car s))])
            (if (char-alphabet? c)
                (loop (cdr s) (hash-update counts c add1 0))
                (loop (cdr s) counts))))))
  (define (char-alphabet? c)
    (and (char>=? c #\a) (char<=? c #\z)))
  (define license-counts (count-chars license-plate))
  (define (matches? word)
    (let loop ([counts license-counts] [word word])
      (if (null? counts)
          #t
          (let ([char (car counts)]
                [required (hash-ref counts (car counts))])
            (let ([actual (count (lambda (c) (= c (char-downcase (car word)))) word)])
              (if (>= actual required)
                  (loop (cdr counts) word)
                  #f)))))
  (define (count pred lst)
    (if (null? lst)
        0
        (+ (if (pred (car lst)) 1 0) (count pred (cdr lst)))))
  (let loop ([words words] [min-word #f] [min-len #f])
    (if (null? words)
        min-word
        (let* ([word (car words)]
               [len (string-length word)]
               [match (matches? word)])
          (if match
              (if (or (not min-word) (< len min-len))
                  (loop (cdr words) word len)
                  (loop (cdr words) min-word min-len))
              (loop (cdr words) min-word min-len))))) )