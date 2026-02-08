(define (find-continuous-array nums)
  (let ((map (make-hash))
        (count 0)
        (result 0))
    (hash-set! map 0 -1)
    (for-each
     (lambda (num i)
       (set! count (+ count (if (= num 0) -1 1)))
       (if (hash-has-key? map count)
           (set! result (- i (hash-ref map count)))
           (hash-set! map count i)))
     nums
     (range (length nums)))
    result))