#lang racket

(define (num-matching-subarrays str pattern)
  (define n (string-length str))
  (define m (string-length pattern))
  (define (kmp-failure)
    (let ((fail (make-vector m 0)))
      (let loop ((i 1) (j 0))
        (when (< i m)
          (cond ((char=? (string-ref pattern i) (string-ref pattern j))
                 (vector-set! fail i j)
                 (loop (+ i 1) (+ j 1)))
                ((> j 0)
                 (loop i (vector-ref fail (- j 1))))
                (else
                 (vector-set! fail i 0)
                 (loop (+ i 1) 0)))))
      fail))

  (define fail (kmp-failure))

  (define (kmp-search)
    (let loop ((i 0) (j 0) (count 0))
      (cond ((>= i n) count)
            ((and (<= j m) (char=? (string-ref str i) (string-ref pattern j)))
             (if (= j (- m 1))
                 (loop (+ i 1) (- j 1) (+ count 1))
                 (loop (+ i 1) (+ j 1) count)))
            ((and (> j 0) (not (char=? (string-ref str i) (string-ref pattern j))))
             (loop i (vector-ref fail (- j 1)) count))
            (else
             (loop (+ i 1) 0 count)))))

  (kmp-search))