(define (num-mutations start end)
  (define (char->index c)
    (- (char->integer c) (char->integer #\A)))
  (define (index->char i)
    (integer->char (+ i (char->integer #\A))))
  (define (mutate s)
    (for/list ([i (in-range 26)])
      (string-append (substring s 0 (random (string-length s))) (index->char i) (substring s (add1 (random (string-length s)))))))
  (define (bfs)
    (let loop ([queue (list (cons start '()))] [visited (set start)])
      (cond [(null? queue) #f]
            [else
             (let* ([current (car queue)]
                    [current-str (car current)]
                    [current-path (cdr current)])
               (if (equal? current-str end)
                   (length current-path)
                   (let ([next-states (mutate current-str)])
                     (loop (append (cdr queue) (filter (lambda (s) (not (set-member? visited s))) (map (lambda (s) (cons s (cons current-str current-path))) next-states))) (set-union visited (list->set next-states))))))]))
  (bfs))