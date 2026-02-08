#lang racket

(define (watched-videos-by-friends friends-relation watched-videos-paths friend-id)
  (define (get-friends id depth)
    (cond [(= depth 0) (list id)]
          [else
           (append-map (lambda (f)
                         (if (member f (car (get-friends f (- depth 1))))
                             '()
                             (get-friends f (- depth 1))))
                       (filter (lambda (x) (not (equal? x friend-id))) (list-ref friends-relation friend-id)))]))

  (define friends (remove-duplicates (get-friends friend-id 2)))
  (define videos (append* (map (lambda (f) (list-ref watched-videos-paths f)) friends)))
  (sort (remove-duplicates videos) string<?))