#lang racket

(define (num-unique-words a b)
  (define (helper s t)
    (let loop ([i 0] [j 0] [count 0])
      (cond [(= i (string-length s)) count]
            [(= j (string-length t)) -1]
            [(char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1) (+ count 1))]
            [else (loop i (+ j 1) count)])))
  (define (count-occurrences s t)
    (let loop ([i 0] [j 0] [count 0])
      (cond [(= i (string-length s)) count]
            [(= j (string-length t)) -1]
            [(char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1) (+ count 1))]
            [else (loop (+ i 1) j count)])))
  (define (is-subsequence s t)
    (let loop ([i 0] [j 0])
      (cond [(= i (string-length s)) #t]
            [(= j (string-length t)) #f]
            [(char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1))]
            [else (loop i (+ j 1))])))
  (define (get-frequency s t)
    (let loop ([i 0] [j 0] [freq 0])
      (cond [(= i (string-length s)) freq]
            [(= j (string-length t)) -1]
            [(char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1) (+ freq 1))]
            [else (loop i (+ j 1) freq)])))
  (define (unique-words a b)
    (let ([len-a (string-length a)]
          [len-b (string-length b)])
      (if (> len-a len-b)
          (unique-words b a)
          (let loop ([i 0] [res '()])
            (if (>= i (- (string-length b) (string-length a) 1))
                (reverse res)
                (let ([sub (substring b i (+ i (string-length a)))])
                  (if (is-subsequence a sub)
                      (loop (+ i 1) (cons sub res))
                      (loop (+ i 1) res))))))))
  (let ([subs (unique-words a b)])
    (if (null? subs)
        0
        (apply + (map (lambda (s) (if (is-subsequence a s) 1 0)) subs)))))

(define (solve a b)
  (num-unique-words a b))