#lang racket

(define (max-score-words letters words)
  (define cnt (make-hash))
  (for-each (lambda (c) (hash-update! cnt c add1 0)) letters)

  (define word-cnt (map (lambda (w) (for/fold ([h (hash)]) ([c w]) (hash-update h c add1 0))) words))

  (define score-map (list (cons #\A 1) (cons #\B 3) (cons #\C 3) (cons #\D 2) (cons #\E 1) (cons #\F 4) (cons #\G 2) (cons #\H 4) (cons #\I 1) (cons #\J 8) (cons #\K 5) (cons #\L 1) (cons #\M 3) (cons #\N 1) (cons #\O 1) (cons #\P 3) (cons #\Q 10) (cons #\R 1) (cons #\S 1) (cons #\T 1) (cons #\U 1) (cons #\V 4) (cons #\W 4) (cons #\X 8) (cons #\Y 4) (cons #\Z 10)))

  (define (get-score w)
    (for/sum ([c w]) (hash-ref score-map c)))

  (define (can-use? word-cnt)
    (for/and ([k (hash-keys word-cnt)]) (<= (hash-ref word-cnt k 0) (hash-ref cnt k 0))))

  (define (backtrack idx current-score)
    (if (= idx (length words))
        current-score
        (let* ([word (list-ref words idx)]
               [word-count (list-ref word-cnt idx)])
          (if (can-use? word-count)
              (max (backtrack (+ idx 1) current-score)
                   (backtrack (+ idx 1) (+ current-score (get-score word))))
              (backtrack (+ idx 1) current-score))))

  (backtrack 0 0))