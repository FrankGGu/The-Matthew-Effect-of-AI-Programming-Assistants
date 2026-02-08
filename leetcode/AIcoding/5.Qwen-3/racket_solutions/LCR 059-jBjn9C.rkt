#lang racket

(define (make-kth-largest k)
  (let ([heap '()])
    (define (push val)
      (set! heap (heap-add heap val))
      (when (> (length heap) k)
        (set! heap (heap-remove-max heap))))
    (define (kth)
      (if (> (length heap) k)
          (heap-ref heap)
          #f))
    (lambda (msg . args)
      (cond
        [(eq? msg 'push) (push (car args))]
        [(eq? msg 'kth) (kth)]))))

(define (main)
  (let ([k (read)]
        [nums (read)])
    (let ([obj (make-kth-largest k)])
      (for-each (lambda (n) ((obj 'push) n)) nums)
      (display ((obj 'kth))))))

(main)