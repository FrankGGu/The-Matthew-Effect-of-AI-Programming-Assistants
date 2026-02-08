#lang racket

(define (make-lfu-cache capacity)
  (define cache (make-hash))
  (define freq (make-hash))
  (define min-freq 0)
  (define (get key)
    (cond [(not (hash-has-key? cache key)) -1]
          [else
           (define entry (hash-ref cache key))
           (define old-freq (car entry))
           (define value (cadr entry))
           (define lst (hash-ref freq old-freq))
           (set! lst (remove key lst))
           (when (null? lst) (hash-remove! freq old-freq))
           (define new-freq (+ old-freq 1))
           (hash-set! freq new-freq (cons key (hash-ref freq new-freq '())))
           (hash-set! cache key (cons new-freq value))
           value]))
  (define (put key value)
    (when (= capacity 0) (void))
    (if (hash-has-key? cache key)
        (begin
          (set! (hash-ref cache key) (cons (car (hash-ref cache key)) value))
          (get key))
        (begin
          (when (>= (hash-count cache) capacity)
            (define evict-key
              (let loop ([f min-freq])
                (if (hash-has-key? freq f)
                    (car (hash-ref freq f))
                    (loop (+ f 1)))))
            (hash-remove! cache evict-key)
            (define lst (hash-ref freq (car (hash-ref cache evict-key))))
            (set! lst (remove evict-key lst))
            (when (null? lst) (hash-remove! freq (car (hash-ref cache evict-key))))
          (hash-set! cache key (cons 1 value))
          (hash-set! freq 1 (cons key (hash-ref freq 1 '())))
          (set! min-freq 1))))
  (lambda (op . args)
    (case op
      [(get) (apply get args)]
      [(put) (apply put args)])))

(define (main)
  (define cache ((make-lfu-cache 2)))
  (cache 'put 1 1)
  (cache 'put 2 2)
  (cache 'get 1)
  (cache 'put 3 3)
  (cache 'get 2)
  (cache 'get 3)
  (cache 'put 4 4)
  (cache 'get 1)
  (cache 'get 3)
  (cache 'get 4))

(main)