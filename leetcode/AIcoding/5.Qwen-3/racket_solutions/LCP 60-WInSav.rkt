#lang racket

(define (find-adjacent-matches grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define visited (make-vector rows (make-vector cols #f)))
  (define result '())

  (define (is-valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (bfs r c color)
    (define queue (list (cons r c)))
    (define visited-copy (vector-map (lambda (v) (vector-copy v)) visited))
    (define count 0)
    (define points '())

    (define (loop q)
      (cond
        [(null? q) (values count points)]
        [else
         (define current (car q))
         (define r (car current))
         (define c (cdr current))
         (when (and (is-valid? r c) (not (vector-ref (vector-ref visited-copy r) c)) (equal? (vector-ref (vector-ref grid r) c) color))
           (vector-set! (vector-ref visited-copy r) c #t)
           (set! count (+ count 1))
           (set! points (cons (cons r c) points))
           (loop (append (cdr q)
                         (filter (lambda (p) (is-valid? (car p) (cdr p)) 
                                 (and (not (vector-ref (vector-ref visited-copy (car p)) (cdr p))) 
                                      (equal? (vector-ref (vector-ref grid (car p) (cdr p)) color))))
                               (list (cons (- r 1) c) (cons (+ r 1) c) (cons r (- c 1)) (cons r (+ c 1)))))))]))

    (loop queue)
    (if (>= count 3)
        (begin
          (set! visited (vector-map (lambda (v) (vector-copy v)) visited-copy))
          (cons count points))
        #f))

  (define (process)
    (for ([r (in-range rows)])
      (for ([c (in-range cols)])
        (when (and (not (vector-ref (vector-ref visited r) c)) (not (equal? (vector-ref (vector-ref grid r) c) #\space)))
          (define res (bfs r c (vector-ref (vector-ref grid r) c)))
          (when res
            (set! result (cons res result))))))
    result)

  (process)
  result)

(define (remove-matches grid matches)
  (define new-grid (map (lambda (row) (vector->list row)) grid))
  (for-each
   (lambda (match)
     (for-each
      (lambda (p)
        (define r (car p))
        (define c (cdr p))
        (vector-set! (vector-ref new-grid r) c #\space))
      (cdr match)))
   matches)
  new-grid)

(define (drop-bubbles grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define new-grid (map (lambda (row) (vector->list row)) grid))

  (for ([c (in-range cols)])
    (define col (map (lambda (r) (vector-ref (vector-ref new-grid r) c)) (range rows)))
    (define non-space (filter (lambda (ch) (not (equal? ch #\space))) col))
    (define space-count (- rows (length non-space)))
    (define new-col (append (make-list space-count #\space) non-space))
    (for ([r (in-range rows)])
      (vector-set! (vector-ref new-grid r) c (list-ref new-col r))))

  new-grid)

(define (bubble-pop grid)
  (define matches (find-adjacent-matches grid))
  (if (null? matches)
      grid
      (let ([new-grid (remove-matches grid matches)])
        (drop-bubbles new-grid))))

(define (solve grid)
  (define (loop g)
    (define new-g (bubble-pop g))
    (if (equal? new-g g)
        g
        (loop new-g)))
  (loop grid))