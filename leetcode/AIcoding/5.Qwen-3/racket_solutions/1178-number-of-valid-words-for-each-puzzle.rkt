#lang racket

(define (find-num-of-valid-wds puzzle words)
  (define (to-bitset s)
    (for/fold ([bits 0]) ([c (in-string s)])
      (bitwise-ior bits (arithmetic-shift 1 (- (char->integer c) (char->integer #\a))))))

  (define (count-subsets bits)
    (let loop ([mask 0] [count 0])
      (if (> mask (sub1 (arithmetic-shift 1 26)))
          count
          (let ([subset (bitwise-and mask bits)])
            (loop (add1 mask) (if (= subset mask) (add1 count) count))))))

  (define (solve)
    (define word-bits (map to-bitset words))
    (define puzzle-bits (map to-bitset puzzle))
    (define freq (make-hash))
    (for-each (lambda (b) (hash-update! freq b add1 0)) word-bits)
    (for/list ([p (in-list puzzle-bits)])
      (define first-char (bitwise-and p (arithmetic-shift 1 (- (char->integer (string-ref (car puzzle) 0)) (char->integer #\a)))))
      (define total 0)
      (for ([mask (in-range (arithmetic-shift 1 26))])
        (when (and (bitwise-and mask p) (bitwise-and mask first-char))
          (set! total (+ total (hash-ref freq mask 0)))))
      total))

  (solve))