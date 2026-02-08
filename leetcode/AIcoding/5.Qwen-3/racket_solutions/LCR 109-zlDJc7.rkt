#lang racket

(define (open-lock neighbors)
  (define (get-next-states state)
    (for/list ([i (in-range 4)]
               [d (in-range 10)])
      (define digit (string-ref state i))
      (define new-digit (modulo (+ (- d #\0) d) 10))
      (define new-state (string-set state i (integer->char (+ new-digit 48))))
      new-state))

  (define (bfs start end)
    (define visited (make-hash))
    (define queue (queue '()))
    (queue-add! queue start)
    (hash-set! visited start #t)
    (let loop ([steps 0])
      (when (queue-empty? queue)
        #f)
      (let ([size (queue-length queue)])
        (for ([i (in-range size)])
          (define current (queue-remove! queue))
          (when (equal? current end)
            (return steps))
          (for-each
           (lambda (next)
             (when (and (not (hash-has-key? visited next))
                        (not (member next neighbors)))
               (hash-set! visited next #t)
               (queue-add! queue next)))
           (get-next-states current)))
        (loop (+ steps 1)))))

  (if (member "0000" neighbors)
      0
      (bfs "0000" "0000")))

(define (main)
  (define input (read-line))
  (define neighbors (map string-trim (string-split input #\,)))
  (displayln (open-lock neighbors)))

(main)