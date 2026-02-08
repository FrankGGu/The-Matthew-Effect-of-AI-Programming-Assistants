#lang racket

(define (dinner-plate-stacks)
  (let ([stacks (list)]
        [leftmost (box 0)])
    (define (push x)
      (let loop ([i 0])
        (cond [(< i (length stacks)) 
               (if (not (null? (list-ref stacks i)))
                   (loop (+ i 1))
                   (begin
                     (set-box! leftmost i)
                     (set! stacks (list-set stacks i (cons x (list-ref stacks i))))
                     #t))]
              [else
               (set! stacks (append stacks (list (list x))))
               #t])))

    (define (pop)
      (let loop ([i (box-value leftmost)])
        (if (null? (list-ref stacks i))
            (begin
              (set-box! leftmost (+ i 1))
              (loop (box-value leftmost)))
            (let ([val (car (list-ref stacks i))])
              (set! stacks (list-set stacks i (cdr (list-ref stacks i))))
              val))))

    (define (peek)
      (let loop ([i (box-value leftmost)])
        (if (null? (list-ref stacks i))
            (begin
              (set-box! leftmost (+ i 1))
              (loop (box-value leftmost)))
            (car (list-ref stacks i)))))

    (define (get_last_non_empty_stack_index)
      (let loop ([i (- (length stacks) 1)])
        (if (< i 0)
            -1
            (if (null? (list-ref stacks i))
                (loop (- i 1))
                i))))

    (define (pop_at index)
      (let ([val (car (list-ref stacks index))])
        (set! stacks (list-set stacks index (cdr (list-ref stacks index))))
        val))

    (lambda (op . args)
      (case op
        [(push) (push (car args))]
        [(pop) (pop)]
        [(peek) (peek)]
        [(pop_at) (pop_at (car args))]
        [(get_last_non_empty_stack_index) (get_last_non_empty_stack_index)])))