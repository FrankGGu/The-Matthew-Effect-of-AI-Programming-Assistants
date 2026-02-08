#lang racket

(define (make-heap)
  (vector 0 0))

(define (heap-size heap)
  (vector-ref heap 0))

(define (heap-data heap)
  (vector-ref heap 1))

(define (set-heap-size! heap size)
  (vector-set! heap 0 size))

(define (set-heap-data! heap data)
  (vector-set! heap 1 data))

(define (heap-empty? heap)
  (= (heap-size heap) 0))

(define (heap-push! heap val)
  (let ([data (heap-data heap)]
        [size (heap-size heap)])
    (set-heap-data! heap (vector-append data (vector val)))
    (set-heap-size! heap (+ size 1))
    (let loop ([i (- size 1)])
      (let ([parent (quotient i 2)])
        (when (> (vector-ref data i) (vector-ref data parent))
          (let ([tmp (vector-ref data i)])
            (vector-set! data i (vector-ref data parent))
            (vector-set! data parent tmp)
            (loop parent)))))))

(define (heap-pop! heap)
  (let ([data (heap-data heap)]
        [size (heap-size heap)])
    (if (heap-empty? heap)
        #f
        (begin
          (let ([val (vector-ref data 0)])
            (vector-set! data 0 (vector-ref data (- size 1)))
            (set-heap-size! heap (- size 1))
            (let loop ([i 0])
              (let* ([left (+ (* i 2) 1)]
                     [right (+ (* i 2) 2)]
                     [max-child (if (and (< left (heap-size heap)) (> (vector-ref data left) (vector-ref data i)))
                                    left
                                    i)]
                     [max-child (if (and (< right (heap-size heap)) (> (vector-ref data right) (vector-ref data max-child)))
                                    right
                                    max-child)])
                (when (/= i max-child)
                  (let ([tmp (vector-ref data i)])
                    (vector-set! data i (vector-ref data max-child))
                    (vector-set! data max-child tmp)
                    (loop max-child))))
            val)))))

(define (sum-query nums queries)
  (let ([heap (make-heap)])
    (for-each (lambda (x) (heap-push! heap x)) nums)
    (let loop ([queries queries] [result '()])
      (if (null? queries)
          (reverse result)
          (let ([q (car queries)])
            (cond
              [(equal? (car q) 'update)
               (let ([index (cadr q)] [value (caddr q)])
                 (let ([data (heap-data heap)])
                   (vector-set! data index value)
                   (let loop ([i index])
                     (let ([parent (quotient i 2)])
                       (when (> (vector-ref data i) (vector-ref data parent))
                         (let ([tmp (vector-ref data i)])
                           (vector-set! data i (vector-ref data parent))
                           (vector-set! data parent tmp)
                           (loop parent)))))
                   (loop (cdr queries) result))]
              [(equal? (car q) 'sum)
               (let ([sum 0])
                 (let loop ([i 0])
                   (when (< i (heap-size heap))
                     (set! sum (+ sum (vector-ref (heap-data heap) i)))
                     (loop (+ i 1))))
                 (loop (cdr queries) (cons sum result)))]
              [else (loop (cdr queries) result)]))))))