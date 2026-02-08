#lang racket

(define (find-rotations ring key)
  (define ring-length (string-length ring))
  (define key-length (string-length key))
  (define pos (make-hash))
  (for ([i (in-range ring-length)]
        [c (in-string ring)])
    (hash-set! pos c (cons i (hash-ref pos c '()))))
  (define (distance a b)
    (min (abs (- a b)) (- ring-length (abs (- a b))))
  )
  (define (dfs index current)
    (if (= index key-length)
        0
        (let ([c (string-ref key index)])
          (apply + (map (lambda (p)
                          (+ (distance current p)
                             (dfs (add1 index) p)))
                        (hash-ref pos c)))))
  )
  (dfs 0 0))

(define (main)
  (define input (current-input-port))
  (define ring (read-line input #f))
  (define key (read-line input #f))
  (printf "~a\n" (find-rotations ring key)))

(main)