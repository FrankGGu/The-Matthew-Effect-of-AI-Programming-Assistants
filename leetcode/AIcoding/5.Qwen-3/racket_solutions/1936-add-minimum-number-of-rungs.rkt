(define (add-minimum-rungs rungs)
  (define (helper current index count)
    (if (>= index (length rungs))
        count
        (let ((next (list-ref rungs index)))
          (if (<= (- next current) 2)
              (helper next (+ index 1) count)
              (helper next (+ index 1) (+ count 1))))))
  (helper 0 0 0))