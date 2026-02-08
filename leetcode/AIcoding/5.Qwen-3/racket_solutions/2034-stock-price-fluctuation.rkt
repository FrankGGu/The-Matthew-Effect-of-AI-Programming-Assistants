#lang racket

(define (make-stock-price-fluctuation)
  (let ([price-map (hash)]
        [min-heap (list)]
        [max-heap (list)])
    (define (insert price)
      (hash-set! price-map price #t)
      (set! min-heap (heap-add min-heap price))
      (set! max-heap (heap-add max-heap (- price))))
    (define (get-min)
      (let loop ()
        (let ([current (heap-top min-heap)])
          (if (hash-has-key? price-map current)
              current
              (begin
                (set! min-heap (heap-pop min-heap))
                (loop)))))
    (define (get-max)
      (let loop ()
        (let ([current (- (heap-top max-heap))])
          (if (hash-has-key? price-map current)
              current
              (begin
                (set! max-heap (heap-pop max-heap))
                (loop)))))
    (define (remove price)
      (hash-remove! price-map price))
    (define (dispatch m . args)
      (cond
        [(eq? m 'insert) (apply insert args)]
        [(eq? m 'get-min) (get-min)]
        [(eq? m 'get-max) (get-max)]
        [(eq? m 'remove) (apply remove args)]
        [else (error "Unknown operation")]))
    dispatch))

(define (call-with-stock-price-fluctuation proc)
  (proc (make-stock-price-fluctuation)))

(define (heap-add h x)
  (cond
    [(null? h) (list x)]
    [else
     (let ([cmp (if (> (car h) x) < >)])
       (if (cmp x (car h))
           (cons x h)
           (cons (car h) (heap-add (cdr h) x))))]))

(define (heap-top h)
  (if (null? h)
      (error "Heap is empty")
      (car h)))

(define (heap-pop h)
  (if (null? h)
      (error "Heap is empty")
      (cdr h)))