(define (longest-arithmetic-subsequence nums)
  (define dp (make-hash))
  (for ([i (in-range (length nums))])
    (for ([j (in-range i)])
      (let* ([diff (- (list-ref nums i) (list-ref nums j))]
             [prev (hash-ref dp j '())]
             [count (if (assoc diff prev) (+ (cdr (assoc diff prev)) 1) 2)])
        (hash-set! dp i (cons (cons diff count) (hash-ref dp i '()))))))
  (apply max (map (lambda (lst) (apply max (map cdr lst))) (hash-values dp))))