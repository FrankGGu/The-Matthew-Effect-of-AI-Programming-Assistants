#lang racket

(define (can-spell-word s cnt)
  (define (helper word cnt)
    (cond [(null? word) #t]
          [(not (hash-has-key? cnt (car word))) #f]
          [else (helper (cdr word) (hash-update cnt (car word) add1))]))
  (helper s cnt))

(define (min-stickers-to-sell-word stickers word)
  (define (count-chars str)
    (for/fold ([cnt (hash)]) ([c str])
      (hash-update cnt c add1)))
  (define word-cnt (count-chars word))
  (define sticker-cnts (map count-chars stickers))
  (define (dfs remaining)
    (if (hash-empty? remaining) 0
        (for/first ([sticker (in-list sticker-cnts)]
                     #:when (and (hash-has-key? sticker (hash-first remaining))
                                 (>= (hash-ref sticker (hash-first remaining)) 1))
                     [cnt (in-value (hash-copy remaining))]
                     [new-remaining (in-value (hash-copy cnt))]
                     #:do (begin
                            (hash-set! new-remaining (hash-first cnt) (- (hash-ref new-remaining (hash-first cnt)) 1))
                            (when (= (hash-ref new-remaining (hash-first cnt)) 0)
                              (hash-remove! new-remaining (hash-first cnt))))
                     #:when (can-spell-word (hash-keys new-remaining) sticker))
          (+ 1 (dfs new-remaining)))))
  (define (bfs)
    (define queue (list (cons (count-chars word) 0)))
    (define visited (set))
    (let loop ([queue queue] [visited visited])
      (cond [(null? queue) -1]
            [else
             (define-values (state steps) (car queue))
             (define next-queue (cdr queue))
             (if (hash-empty? state) steps
                 (begin
                   (define new-states (for/list ([sticker (in-list sticker-cnts)])
                                        (define new-state (hash-copy state))
                                        (for ([c (in-hash-keys sticker)])
                                          (when (hash-has-key? new-state c)
                                            (hash-set! new-state c (- (hash-ref new-state c) (hash-ref sticker c)))
                                            (when (= (hash-ref new-state c) 0)
                                              (hash-remove! new-state c))))
                                        new-state))
                   (define next-queue (append next-queue (map (lambda (s) (cons s steps)) (filter (lambda (s) (not (set-member? visited s))) new-states))))
                   (loop next-queue (set-union visited (set-map new-states set))))))]))
  (bfs))