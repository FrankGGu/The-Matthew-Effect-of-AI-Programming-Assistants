#lang racket

(define/contract (furthest-building dist bricks ladders)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let loop ([i 0] [heap '()] [bricks 0])
    (if (>= i (length dist))
        (- i 1)
        (let* ([d (list-ref dist i)]
               [new-bricks (- bricks d)])
          (if (<= new-bricks 0)
              (let ([min-req (apply min (cons (abs new-bricks) (map abs heap)))])
                (if (and (not (null? heap)) (<= min-req (abs new-bricks)))
                    (loop (+ i 1) (remove-min heap) (+ bricks (abs min-req)))
                    (- i 1)))
              (loop (+ i 1) (heap-add heap d) new-bricks))))))

(define (heap-add heap x)
  (cond [(null? heap) (list x)]
        [(<= x (car heap)) (cons x heap)]
        [else (cons (car heap) (heap-add (cdr heap) x))]))

(define (remove-min heap)
  (cond [(null? (cdr heap)) '()]
        [else (cons (cadr heap) (cdr heap))]))