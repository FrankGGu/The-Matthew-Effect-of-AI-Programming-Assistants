#lang racket

(define (max-path-score board)
  (define rows (length board))
  (define cols (string-length (car board)))
  (define dp (make-vector rows (make-vector cols 0)))
  (define count (make-vector rows (make-vector cols 0)))

  (vector-set! count 0 0 1)
  (vector-set! dp 0 0 (- (string-ref (vector-ref board 0) 0) 48))

  (define (get-value i j)
    (if (and (<= 0 i (- rows 1)) (<= 0 j (- cols 1)))
        (- (string-ref (vector-ref board i) j) 48)
        0))

  (define (update i j)
    (let ([val (get-value i j)])
      (when (not (= val 0))
        (let ([max-val -1]
              [total 0])
          (for-each
           (lambda (di)
             (for-each
              (lambda (dj)
                (when (and (<= 0 (+ i di) (- rows 1))
                           (<= 0 (+ j dj) (- cols 1)))
                  (let ([prev-dp (vector-ref (vector-ref dp (+ i di)) (+ j dj))])
                    (when (> prev-dp max-val)
                      (set! max-val prev-dp)
                      (set! total (vector-ref (vector-ref count (+ i di)) (+ j dj))))
                    (when (= prev-dp max-val)
                      (set! total (+ total (vector-ref (vector-ref count (+ i di)) (+ j dj))))))))
              '(0 -1))
           '(0 -1))
          (when (>= max-val 0)
            (vector-set! dp i j (+ max-val val))
            (vector-set! count i j total))))))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (and (= i 0) (= j 0))
        (void))
      (when (or (= i 0) (= j 0))
        (if (= i 0)
            (update 0 j)
            (update i 0)))
      (when (and (> i 0) (> j 0))
        (update i j))))

  (vector-ref (vector-ref count (- rows 1) (- cols 1)) 0))

(define (main)
  (define input (current-command-line-arguments))
  (define board (map (lambda (s) s) (string-split (vector-ref input 0) "|")))
  (display (max-path-score board)))

(main)