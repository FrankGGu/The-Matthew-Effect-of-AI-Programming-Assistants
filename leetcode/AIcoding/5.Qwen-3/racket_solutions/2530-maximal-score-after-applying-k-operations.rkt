(define (maximal-score nums k)
  (define (heapify lst)
    (let loop ((i 0) (lst lst))
      (if (>= i (floor (/ (length lst) 2)))
          lst
          (let* ((left (+ (* i 2) 1))
                 (right (+ (* i 2) 2))
                 (min-child (if (and (< right (length lst)) (> (list-ref lst left) (list-ref lst right)))
                                right
                                left))
                 (min-val (list-ref lst min-child)))
        (if (> (list-ref lst i) min-val)
            (loop 0 (list-set (list-set lst i min-val) min-child (list-ref lst i)))
            (loop (+ i 1) lst))))))

  (define (extract-max lst)
    (let ((max-val (car lst)))
      (append (list (last lst)) (cdr (reverse (take lst (- (length lst) 1)))))))

  (define (insert lst val)
    (append lst (list val)))

  (define (build-heap lst)
    (let loop ((i (floor (/ (length lst) 2))) (lst lst))
      (if (< i 0)
          lst
          (loop (- i 1) (heapify lst)))))

  (define (get-max lst)
    (car lst))

  (define (apply-operations nums k)
    (let ((heap (build-heap nums)))
      (let loop ((heap heap) (k k) (score 0))
        (if (= k 0)
            score
            (let* ((max-val (get-max heap))
                   (new-val (quotient max-val 2))
                   (new-heap (extract-max heap))
                   (new-heap (insert new-heap new-val)))
              (loop new-heap (- k 1) (+ score max-val)))))))

  (apply-operations nums k))